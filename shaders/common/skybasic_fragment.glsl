#include "/lib/config.glsl"
#include "/lib/meteor_system.glsl"
#include "/lib/circular_sun_moon.glsl"

/* Color utils */

#ifdef THE_END
    #include "/lib/color_utils_end.glsl"
#elif defined NETHER
    #include "/lib/color_utils_nether.glsl"
#else
    #include "/lib/color_utils.glsl"
#endif

/* Uniforms */

uniform sampler2D gaux4;
uniform float pixel_size_x;
uniform float pixel_size_y;
uniform float frameTimeCounter;
uniform vec3 sunPosition;
uniform vec3 moonPosition;

#ifdef NETHER
    uniform vec3 fogColor;
#endif

#if MC_VERSION < 11604
    uniform mat4 gbufferProjectionInverse;
    uniform float viewWidth;
    uniform float viewHeight;
    uniform float rainStrength;
#endif

/* Ins / Outs */

#if MC_VERSION < 11604
    varying vec3 up_vec;
    varying vec3 hi_sky_color;
    varying vec3 low_sky_color;
#endif

varying vec4 star_data;
varying vec4 meteor_data;
varying vec2 sky_coordinate;
varying vec3 world_position;
varying vec4 sun_moon_data;

/* Utility functions */

#if MC_VERSION < 11604
    #include "/lib/dither.glsl"
#endif

// MAIN FUNCTION ------------------

void main() {
    #if defined THE_END
        #if MC_VERSION < 11604
            vec4 background_color = vec4(ZENITH_DAY_COLOR, 1.0);
        #endif
        
        // Beautiful purple stars for End dimension
        vec4 block_color = star_data;
        
        // Ultra-bright purple star glow effect
        if (star_data.a > 0.0) {
            vec3 enhanced_purple = vec3(1.0, 0.4, 1.0) * star_data.a * 3.2;
            enhanced_purple += vec3(1.0, 0.7, 1.0) * star_data.a * 1.2; // Bright inner glow
            enhanced_purple += vec3(0.8, 0.3, 0.9) * star_data.a * 0.9; // Strong outer glow
            enhanced_purple += vec3(0.9, 0.5, 1.0) * star_data.a * 0.6; // Extra sparkle
            block_color = vec4(enhanced_purple, star_data.a * 2.4);
        } else {
            block_color = vec4(0.0, 0.0, 0.0, 1.0);
        }
    #elif defined NETHER  // Unused
        #if MC_VERSION < 11604
            vec4 background_color = vec4(mix(fogColor * 0.1, vec3(1.0), 0.04), 1.0);
        #endif
        vec4 block_color = vec4(mix(fogColor * 0.1, vec3(1.0), 0.04), 1.0);
    #else
        #if MC_VERSION < 11604
            #if AA_TYPE > 0
                float dither = shifted_r_dither(gl_FragCoord.xy);
            #else
                float dither = dither13(gl_FragCoord.xy);
            #endif

            dither = (dither - .5) * 0.03125;

            vec4 fragpos =
                gbufferProjectionInverse *
                (vec4(gl_FragCoord.xy * vec2(pixel_size_x, pixel_size_y), gl_FragCoord.z, 1.0) * 2.0 - 1.0);
            vec3 nfragpos = normalize(fragpos.xyz);
            float n_u = clamp(dot(nfragpos, up_vec) + dither, 0.0, 1.0);
            vec4 background_color = vec4(mix(low_sky_color, hi_sky_color, smoothstep(0.0, 1.0, pow(n_u, 0.333))), 1.0);
            background_color.rgb = xyz_to_rgb(background_color.rgb);
        #else

            // Toma el color puro del bloque
            vec4 background_color = texture2DLod(gaux4, gl_FragCoord.xy * vec2(pixel_size_x, pixel_size_y), 0);
        #endif

        // Vanilla stars for Overworld nighttime
        vec4 block_color = star_data;
        
        // Ultra-enhanced vanilla star rendering
        if (star_data.a > 0.0) {
            // Very bright vanilla stars with strong glow
            vec3 star_color = star_data.rgb * 1.8;
            star_color += vec3(1.0, 1.0, 0.9) * star_data.a * 0.8; // Bright warm glow
            star_color += vec3(0.9, 0.9, 1.0) * star_data.a * 0.4; // Cool highlight
            block_color = vec4(star_color, star_data.a * 1.6);
        }
        
        #ifdef METEOR_SYSTEM
            // Add beautiful falling meteors
            #if MC_VERSION < 11604
                vec4 meteors = renderMeteorSystem(sky_coordinate, frameTimeCounter, night_mixer);
                if (meteors.a > 0.0) {
                    // Blend meteors with existing sky content
                    block_color.rgb += meteors.rgb * meteors.a;
                    block_color.a = max(block_color.a, meteors.a * 0.9);
                }
            #endif
        #endif
        
        #ifdef CIRCULAR_SUN_MOON
            // Add circular sun and moon
            #if MC_VERSION < 11604
                vec4 sunMoon = renderCircularSunMoon(world_position, normalize(sunPosition), 
                                                   normalize(moonPosition), day_mixer, night_mixer, 
                                                   moonPhase, rainStrength);
                if (sunMoon.a > 0.0) {
                    // Blend sun/moon with existing sky content
                    block_color.rgb += sunMoon.rgb * sunMoon.a;
                    block_color.a = max(block_color.a, sunMoon.a);
                }
            #endif
        #endif

        block_color = mix(background_color, block_color, block_color.a);

        #if MC_VERSION >= 11604
            // block_color.a = star_data.a;
        #endif
    #endif

    block_color.rgba = vec4(texture2D(gaux4, gl_FragCoord.xy * vec2(pixel_size_x, pixel_size_y)).rgb, clamp(star_data.a * 2.0, 0.0, 1.0));

    #include "/src/writebuffers.glsl"
}
