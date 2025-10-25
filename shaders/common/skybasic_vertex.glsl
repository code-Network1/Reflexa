#include "/lib/config.glsl"

/* Color utils */

#if MC_VERSION < 11604
    #ifdef THE_END
        #include "/lib/color_utils_end.glsl"
    #elif defined NETHER
        #include "/lib/color_utils_nether.glsl"
    #else
        #include "/lib/color_utils.glsl"
    #endif
#endif

/* Uniforms */

uniform mat4 gbufferModelView;
uniform float frameTimeCounter;
uniform vec3 cameraPosition;
uniform vec3 sunPosition;
uniform vec3 moonPosition;

#if MC_VERSION < 11604
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

#if AA_TYPE > 0
    #include "/src/taa_offset.glsl"
#endif

#if MC_VERSION < 11604
    #include "/lib/luma.glsl"
#endif

// MAIN FUNCTION ------------------

void main() {
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

    #if AA_TYPE > 0
        gl_Position.xy += taa_offset * gl_Position.w;
    #endif

    #ifdef THE_END
        // Purple stars for End dimension
        float star_intensity = float(gl_Color.r == gl_Color.g &&
                                   gl_Color.g == gl_Color.b &&
                                   gl_Color.r > 0.0) * gl_Color.r;
        
        // Ultra-bright purple star colors
        vec3 purple_star_color = vec3(0.9, 0.5, 1.0) * star_intensity * 2.8;
        star_data = vec4(purple_star_color, star_intensity * 2.2);
    #else
        // Enhanced vanilla stars for Overworld at night
        float star_intensity = float(gl_Color.r == gl_Color.g &&
                                   gl_Color.g == gl_Color.b &&
                                   gl_Color.r > 0.0) * gl_Color.r;
        
        #if MC_VERSION < 11604
            // Enable stars only at night with enhanced visibility
            star_intensity *= night_mixer * 2.5; // Much brighter stars
        #endif
        
        // Bright white/yellow star colors with enhanced clarity
        vec3 vanilla_star_color = vec3(1.0, 1.0, 0.85) * star_intensity * 2.0;
        star_data = vec4(vanilla_star_color, star_intensity * 1.8);
    #endif

    // Sky coordinate for meteor system
    vec4 world_pos = gbufferModelView * gl_Vertex;
    sky_coordinate = world_pos.xy * 0.01 + vec2(0.5);
    
    // World position for sun/moon rendering
    world_position = normalize(world_pos.xyz);
    
    #ifdef METEOR_SYSTEM
        #ifndef THE_END
            // Initialize meteor data (will be calculated in fragment shader)
            meteor_data = vec4(0.0);
        #else
            meteor_data = vec4(0.0);
        #endif
    #else
        meteor_data = vec4(0.0);
    #endif
    
    #ifdef CIRCULAR_SUN_MOON
        #ifndef THE_END
            // Initialize sun/moon data (will be calculated in fragment shader)
            sun_moon_data = vec4(0.0);
        #else
            sun_moon_data = vec4(0.0);
        #endif
    #else
        sun_moon_data = vec4(0.0);
    #endif

    #if MC_VERSION < 11604
        up_vec = normalize(gbufferModelView[1].xyz);

        #include "/src/hi_sky.glsl"
        #include "/src/low_sky.glsl"
    #endif
}
