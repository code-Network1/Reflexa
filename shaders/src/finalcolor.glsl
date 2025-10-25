#if defined THE_END
    if(isEyeInWater == 0 && FOG_ADJUST < 15.0) {  // In the air
        block_color.rgb = mix(block_color.rgb, ZENITH_DAY_COLOR, frog_adjust);
    }
#elif defined NETHER
    #ifndef NETHER_CLEAR_VIEW
        if(isEyeInWater == 0 && FOG_ADJUST < 15.0) {  // In the air
            block_color.rgb = mix(block_color.rgb, mix(fogColor * 0.1, vec3(1.0), 0.04), frog_adjust);
        }
    #endif
    // Nether fog completely disabled for clear visibility
#else
    #ifdef FOG_ACTIVE  // Fog active
        #if MC_VERSION >= 11900
            vec3 fog_texture;
            if(darknessFactor > .01) {
                fog_texture = vec3(0.0);
            } else {
                fog_texture = texture2D(gaux4, gl_FragCoord.xy * vec2(pixel_size_x, pixel_size_y)).rgb;
            }
        #else
            vec3 fog_texture = texture2D(gaux4, gl_FragCoord.xy * vec2(pixel_size_x, pixel_size_y)).rgb;
        #endif
        #if defined GBUFFER_ENTITIES
            if(isEyeInWater == 0 && entityId != 10101 && FOG_ADJUST < 15.0) {  // In the air
                block_color.rgb = mix(block_color.rgb, fog_texture, frog_adjust);
            } else if(isEyeInWater == 1) {  // Underwater enhanced fog
                float underwater_depth = gl_FogFragCoord * 0.05 * UNDERWATER_FOG_DISTANCE;
                vec3 underwater_fog_color = vec3(WATER_COLOR_R, WATER_COLOR_G, WATER_COLOR_B) * 0.3;
                float fog_mix = clamp(underwater_depth * UNDERWATER_FOG_DENSITY, 0.0, 0.8);
                block_color.rgb = mix(block_color.rgb, underwater_fog_color, fog_mix);
            }
        #else
            if(isEyeInWater == 0) {  // In the air
                block_color.rgb = mix(block_color.rgb, fog_texture, frog_adjust);
            } else if(isEyeInWater == 1) {  // Underwater enhanced fog
                float underwater_depth = gl_FogFragCoord * 0.05 * UNDERWATER_FOG_DISTANCE;
                vec3 underwater_fog_color = vec3(WATER_COLOR_R, WATER_COLOR_G, WATER_COLOR_B) * 0.3;
                float fog_mix = clamp(underwater_depth * UNDERWATER_FOG_DISTANCE, 0.0, 0.8);
                block_color.rgb = mix(block_color.rgb, underwater_fog_color, fog_mix);
            }
        #endif
    #endif
#endif

// Removed gradual blindness effects for instant weather transitions
// #if MC_VERSION >= 11900
//     if(blindness > .01 || darknessFactor > .01) {
//         block_color.rgb = mix(block_color.rgb, vec3(0.0), max(blindness, darknessLightFactor) * gl_FogFragCoord * 0.24);
//     }
// #else
//     if(blindness > .01) {
//         block_color.rgb = mix(block_color.rgb, vec3(0.0), blindness * gl_FogFragCoord * 0.24);
//     }
// #endif
