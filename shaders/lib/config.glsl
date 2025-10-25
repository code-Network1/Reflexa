/* Reflexa - config.glsl
Config variables

VcorA - All Rights Reserved
*/

// Useful entities
#define ENTITY_SMALLGRASS     10031.0  // Normal grass like entities
#define ENTITY_LOWERGRASS     10175.0  // Lower half only
#define ENTITY_UPPERGRASS     10176.0  // Upper half only
#define ENTITY_SMALLENTS      10059.0  // Crops like entities
#define ENTITY_SMALLENTS_NW   10032.0  // No waveable small ents
#define ENTITY_LEAVES         10018.0  // Leaves
#define ENTITY_VINES          10106.0  // Vines
#define ENTITY_EMMISIVE       10089.0  // Emissors
#define ENTITY_S_EMMISIVE     10090.0  // Emissors
#define ENTITY_F_EMMISIVE     10213.0  // Fake emissors
#define ENTITY_GLOWING_FLOWERS 10216.0  // Glowing flowers only (not grass)
#define ENTITY_NO_SHADOW_FIRE 10214.0  // Fire (no shadow)
#define ENTITY_WATER          10008.0  // Water
#define ENTITY_PORTAL         10090.0  // Portal
#define ENTITY_STAINED        10079.0  // Glass
#define ENTITY_METAL          10400.0  // Metal-like glossy blocks
#define ENTITY_SAND           10410.0  // Sand-like glossy blocks
#define ENTITY_FABRIC         10440.0  // Fabric-like glossy blocks

// Other constants
#define ZENITH_SKY_RAIN_COLOR vec3(.7, .85, 1.0)
#define HORIZON_SKY_RAIN_COLOR vec3(0.35 , 0.425, 0.5)

// Options
#define REFLECTION_SLIDER 2 // [0 1 2] Reflection quality. - Flipped image: Inaccurate but quick reflection. - Raymarching: Raytraced Screen Space Reflection.

#if REFLECTION_SLIDER == 0
    #define REFLECTION 0
    #define SSR_TYPE 0
    #define REFLEX_INDEX 0.45
#elif REFLECTION_SLIDER == 1
    #define REFLECTION 1
    #define SSR_TYPE 0
    #define REFLEX_INDEX 0.7
#elif REFLECTION_SLIDER == 2
    #define REFLECTION 1
    #define SSR_TYPE 1
    #define REFLEX_INDEX 0.35
#endif

#define FOG_ACTIVE // Toggle fog
#define NETHER_FOG_DISTANCE 0 // [0 1] // DISABLED: No fog in Nether for clear visibility
#define ACERCADE 0 // [0]
#define WAVING 1 // [0 1] Makes objects like leaves or grass move in the wind
#define TINTED_WATER 1  // [0 1] Use the resource pack color for water.
#define REFRACTION 1  // [0 1] Activate refractions.
// #define DOF // Enables depth of field (high performance cost).
#define DOF_STRENGTH 0.09  // [0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13]  Depth of field strength.
#define AO 1  // [0 1] Turn on for enhanced ambient occlusion (medium performance cost).
#define AOSTEPS 6 // [2 3 4 5 6 7 8 9 10 11] Enhanced AO sampling for better shadow details
#define AO_STRENGTH 0.80 // Enhanced AO strength for detailed object shadows
#define AA_TYPE 2 // [0 1 2 3]  No: Disable antialiasing (not recommended). Denoise only: Supersampling is only used to eliminate noise. TAA: Enable antialiasing. TAA+: Use FXAA to improve the result of TAA. It does not apply if chromatic aberration or DoF is being used.
//#define MOTION_BLUR // Turn on motion blur
#define MOTION_BLUR_STRENGTH 1.0 // [0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0] Set Motion blur strength. Lower framerate -> Lower strength and vice versa is recommended.
#define MOTION_BLUR_SAMPLES 4 // [3 4 5 6 7 8] Motion blur samples 
#define SUN_REFLECTION 1 // [0 1] Enable sun (or moon) reflection on water and glass

#define SHADOW_TYPE 1 // [0 1] Sets the shadow type
#define SHADOW_BLUR 0.8 // Enhanced shadow sharpness for maximum object detail
#define COLORED_SHADOW // Attempts to tint the shadow of translucent objects, as well as the associated volumetric light (if active).
#define WATER_ABSORPTION 0.25 // [0.02 0.04 0.06 0.08 0.10 0.12 0.14 0.16 0.18 0.20 0.22 0.24 0.26 0.28 0.30 0.32 0.34 0.36 0.38 0.40 0.42 0.44 0.46 0.48 0.50 0.52 0.54 0.56 0.58 0.60 0.62 0.64 0.66 0.68 0.70 0.72 0.74 0.76 0.78 0.80] Water absorption increased for less transparency from outside
#define UNDERWATER_FOG_DENSITY 0.75 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5] Underwater fog density for realistic diving experience
#define UNDERWATER_FOG_DISTANCE 0.8 // [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2] How quickly underwater fog builds up with distance
#define COLOR_SCHEME 1 // [0 1 2 3 4 5 6 7 99] Ethereal: Old default theme. New shoka: Reinterpretation of a classic. Shoka: The classic. Legacy: Very old default. Captain: A cold preset of stylish colors. Psycodelic: Remaster of old vivid scheme. Cocoa: Warm theme. Testigo: Fantasy and cute scheme. Custom: Choose your colors in advanced options. 
#define WATER_TEXTURE 0 // [0 1] Enable or disable resource pack water texture. It does not work properly in 1.12. In that case the default value is recommended.
#define AVOID_DARK_LEVEL 0.050 // [0.000 0.005 0.010 0.015 0.020 0.025 0.030 0.035 0.040 0.045 0.050 0.055 0.060]  Minimal omni light intensity in caves.
#define NIGHT_BRIGHT 0.65 // [0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70] Adjusts the brightness of the night light in exteriors.
#define V_CLOUDS 2 // [0 1 2] Enhanced Dynamic Clouds: Clouds change shape over time for more natural appearance. Volumetric static: Fixed shape clouds. Vanilla: Original vanilla clouds.
// Cloud volumetric style fixed to natural (blocky style removed)
#define CLOUD_REFLECTION  // Set off-screen volumetric clouds reflection (volumetric clouds must be active).
// #define END_CLOUDS // Disabled: No clouds in the End dimension (dragon world)
#define END_PURPLE_STARS // Beautiful purple stars in End dimension instead of clouds
#define METEOR_SYSTEM // Enable beautiful falling meteor system
#define NETHER_CLEAR_VIEW // Completely clear Nether visibility without fog
#define CIRCULAR_SUN_MOON // Make sun and moon perfectly circular instead of square
#define BLACK_ENTITY_FIX 0 // [0 1] Removes black entity bug in old video drivers (activate ONLY if you have problems with black entities)
#define BLOOM // Enable or disable bloom effect
#define BLOOM_SAMPLES 3.0 // [2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0] Enhanced bloom details
#define CHROMA_ABER 0 // [0 1] Enable chroma aberration.
#define CHROMA_ABER_STRENGTH 0.04 // [0.04 0.05 0.06] Chroma aberration strength.
#define VOL_LIGHT 1 // [0 1 2] Depth based: Turn on depth based godrays, faster and can work better than volumetric light for very short shadow distances. Volumetric: It activates the volumetric light, more accurate and faster, but it needs the shadows enabled to work.
// #define VANILLA_WATER // Establishes the appearance of water as vanilla.
#define WATER_COLOR_SOURCE 0 // [0 1] Select the water color source. It does not work properly in 1.12. In that case the default value is recommended.
#define WATER_TURBULENCE 0.9 // [7.0 1.75 0.9 0.5] Set the water waves strength.
#define FOG_ADJUST 0.6 // Reduced fog for better shadow visibility
// #define DEBUG_MODE // Set debug mode.
#define BLOCKLIGHT_TEMP 2 // [0 1 2 3 4] Set blocklight temperature (enhanced for better color visibility)
#define MATERIAL_GLOSS // A very subtle effect that adds some ability to reflect direct light on some blocks. It is most noticeable on metals and luminous objects.
#define DYN_HAND_LIGHT // Toggle the fake dynamic light

// Custom colors
#define LIGHT_SUNSET_COLOR_R 1.0 // Enhanced sunset warmth
#define LIGHT_SUNSET_COLOR_G 0.65 // Enhanced sunset warmth
#define LIGHT_SUNSET_COLOR_B 0.40 // Enhanced sunset warmth

#define LIGHT_DAY_COLOR_R 0.95 // Enhanced for better color visibility
#define LIGHT_DAY_COLOR_G 0.88 // Enhanced for better color visibility  
#define LIGHT_DAY_COLOR_B 0.82 // Enhanced for better color visibility

#define LIGHT_NIGHT_COLOR_R 0.05 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]
#define LIGHT_NIGHT_COLOR_G 0.05 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]
#define LIGHT_NIGHT_COLOR_B 0.06 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]

#define ZENITH_SUNSET_COLOR_R 0.14 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define ZENITH_SUNSET_COLOR_G 0.24 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define ZENITH_SUNSET_COLOR_B 0.36 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]

#define ZENITH_DAY_COLOR_R 0.14 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define ZENITH_DAY_COLOR_G 0.24 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define ZENITH_DAY_COLOR_B 0.36 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]

#define ZENITH_NIGHT_COLOR_R 0.014 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]
#define ZENITH_NIGHT_COLOR_G 0.019 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]
#define ZENITH_NIGHT_COLOR_B 0.025 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]

#define HORIZON_SUNSET_COLOR_R 1.0 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define HORIZON_SUNSET_COLOR_G 0.65 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define HORIZON_SUNSET_COLOR_B 0.38 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]

#define HORIZON_DAY_COLOR_R 0.65 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define HORIZON_DAY_COLOR_G 0.91 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]
#define HORIZON_DAY_COLOR_B 1.3 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]

#define HORIZON_NIGHT_COLOR_R 0.021 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]
#define HORIZON_NIGHT_COLOR_G 0.031 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]
#define HORIZON_NIGHT_COLOR_B 0.039 // [0.0 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.02 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.03 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.04 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.05 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.06 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.07 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.08 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.09 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.1 0.101 0.102 0.103 0.104 0.105 0.106 0.107 0.108 0.109 0.11 0.111 0.112 0.113 0.114 0.115 0.116 0.117 0.118 0.119 0.12 0.121 0.122 0.123 0.124 0.125 0.126 0.127 0.128 0.129 0.13 0.131 0.132 0.133 0.134 0.135 0.136 0.137 0.138 0.139 0.14 0.141 0.142 0.143 0.144 0.145 0.146 0.147 0.148 0.149 0.15]

#define WATER_COLOR_R 0.12 // Enhanced water opacity - increased red component
#define WATER_COLOR_G 0.18 // Enhanced water opacity - increased green component
#define WATER_COLOR_B 0.22 // Enhanced water opacity - increased blue component

#define NV_COLOR_R 0.5 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]
#define NV_COLOR_G 0.8 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]
#define NV_COLOR_B 1.0 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]

#define OMNI_TINT_CUSTOM 0.3 // [0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5]

// Enhanced underwater fog settings for realistic diving experience
#define UNDERWATER_FOG_DENSITY 0.75 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5] Underwater fog density
#define UNDERWATER_FOG_DISTANCE 0.8 // [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2] How quickly underwater fog builds up with distance

#ifdef FOG_ACTIVE
    // Don't remove
#endif

#if NETHER_FOG_DISTANCE == 1
    #define NETHER_SIGHT min(far / 2, 96)
#else
    #define NETHER_SIGHT far
#endif

// Reflection parameters
#define RAYMARCH_STEPS 10

// Ultra-realistic cloud parameters with enhanced layering
#define CLOUD_PLANE_SUP 720.0
#define CLOUD_PLANE_CENTER 480.0
#define CLOUD_PLANE 380.0

#define CLOUD_STEPS_AVG 15 // [7 8 9 10 11 12 13 14 15 16] Ultra-high cloud sampling for maximum realism and detail.
#define CLOUD_SPEED 0 // [0 1 2] Slow realistic cloud movement for natural atmosphere.

// Ultra-slow realistic cloud motion for peaceful atmosphere
#if CLOUD_SPEED == 0
    #define CLOUD_HI_FACTOR 0.0008
    #define CLOUD_LOW_FACTOR 0.0001333333333333333
#elif CLOUD_SPEED == 1
    #define CLOUD_HI_FACTOR 0.008
    #define CLOUD_LOW_FACTOR 0.001333333333333333
#elif CLOUD_SPEED == 2
    #define CLOUD_HI_FACTOR 0.08
    #define CLOUD_LOW_FACTOR 0.01333333333333333
#endif

// Maximum density ultra-realistic cloud appearance settings
#define CLOUD_DENSITY 0.95 // [0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2] Balanced density to avoid black fog
#define CLOUD_COVERAGE 0.95 // [0.4 0.5 0.6 0.7 0.8 0.9 1.0] Maximum sky coverage for overcast atmosphere
#define CLOUD_BRIGHTNESS 1.5 // [0.8 0.9 1.0 1.1 1.2 1.3 1.4] Increased brightness to eliminate black fog
#define CLOUD_CONTRAST 1.25 // Enhanced contrast for more defined cloud edges
#define CLOUD_DEPTH_MULTIPLIER 1.4 // Increased depth perception for 3D cloud appearance
#define CLOUD_SHADOW_INTENSITY 0.45 // Reduced shadow intensity to prevent black fog
#define CLOUD_THICKNESS 1.1 // Balanced thickness to prevent over-darkening
#define CLOUD_LAYERING 1.25 // Multiple cloud layers for complex sky patterns

// Godrays
#define GODRAY_STEPS 6
#define CHEAP_GODRAY_SAMPLES 4

// Color blindness
// #define COLOR_BLINDNESS  // Enable color blindness correction
#define COLOR_BLIND_MODE 0  // [0 1 2]  Set color blindness type

// Sun rotation angle
const float sunPathRotation = -25.0; // [-40.0 -35.0 -30.0 -25.0 -20.0 -15.0 -10.0 -5.0 0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0]

#define SHADOW_DISTANCE_SLIDER 1 // [0 1 2]
#define SHADOW_QTY_SLIDER 2 // [1 2 3]

#define SHADOW_CASTING // Enable or disable shadows. Configure quality in advanced options.

#ifdef SHADOW_CASTING
    // Shadow parameters
    const float shadowIntervalSize = 3.0;

    const bool shadowtex0Mipmap = false;
    const bool shadowtex1Mipmap = false;
    const bool shadowColor0Mipmap = false;
    const bool shadowColor1Mipmap = false;

    const bool shadowtex0Clear = false;
    const bool shadowtex1Clear = false;
    const bool shadowcolor0Clear = false;
    const bool shadowcolor1Clear = false;
    
    #ifndef NO_SHADOWS
        #if SHADOW_DISTANCE_SLIDER == 0
            #if SHADOW_QTY_SLIDER == 1
                #define SHADOW_LIMIT 75.0
                const int shadowMapResolution = 300;
                const float shadowDistance = 75.0;
                #define SHADOW_FIX_FACTOR 0.3
                #define SHADOW_DIST 0.75

            #elif SHADOW_QTY_SLIDER == 2
                #define SHADOW_LIMIT 75.0
                const int shadowMapResolution = 600;
                const float shadowDistance = 75.0;
                #define SHADOW_FIX_FACTOR 0.15
                #define SHADOW_DIST 0.81

            #elif SHADOW_QTY_SLIDER == 3
                #define SHADOW_LIMIT 75.0
                const int shadowMapResolution = 1200;
                const float shadowDistance = 75.0;
                #define SHADOW_FIX_FACTOR 0.05
                #define SHADOW_DIST 0.81
            
            #endif

        #elif SHADOW_DISTANCE_SLIDER == 1
            #if SHADOW_QTY_SLIDER == 1
                #define SHADOW_LIMIT 105.0
                const int shadowMapResolution = 420;
                const float shadowDistance = 105.0;
                #define SHADOW_FIX_FACTOR 0.28
                #define SHADOW_DIST 0.75

            #elif SHADOW_QTY_SLIDER == 2
                #define SHADOW_LIMIT 105.0
                const int shadowMapResolution = 840;
                const float shadowDistance = 105.0;
                #define SHADOW_FIX_FACTOR 0.07
                #define SHADOW_DIST 0.83

            #elif SHADOW_QTY_SLIDER == 3
                #define SHADOW_LIMIT 105.0
                const int shadowMapResolution = 1680;
                const float shadowDistance = 105.0;
                #define SHADOW_FIX_FACTOR 0.03
                #define SHADOW_DIST 0.83
            
            #endif

        #elif SHADOW_DISTANCE_SLIDER == 2
            #if SHADOW_QTY_SLIDER == 1
                #define SHADOW_LIMIT 255.0
                const int shadowMapResolution = 1020;
                const float shadowDistance = 255.0;
                #define SHADOW_FIX_FACTOR 0.12
                #define SHADOW_DIST 0.8

            #elif SHADOW_QTY_SLIDER == 2
                #define SHADOW_LIMIT 255.0
                const int shadowMapResolution = 2040;
                const float shadowDistance = 255.0;
                #define SHADOW_FIX_FACTOR 0.03
                #define SHADOW_DIST 0.85

            #elif SHADOW_QTY_SLIDER == 3
                #define SHADOW_LIMIT 255.0
                const int shadowMapResolution = 4080;
                const float shadowDistance = 255.0;
                #define SHADOW_FIX_FACTOR 0.015
                #define SHADOW_DIST 0.87

            #endif
        #endif

        #if VOL_LIGHT == 2
            const float shadowDistanceRenderMul = -1.0;
        #else
            const float shadowDistanceRenderMul = 1.0;
        #endif
        
        const bool shadowHardwareFiltering = true;
        const bool shadowtex1Nearest = false;
    #endif

#else
    #define SHADOW_DIST 0.0
    #define SHADOW_RES 0
    const int shadowMapResolution = 100;
    const float shadowDistance = 60.0;
#endif

// Redefined constants
#if AO == 0
    const float ambientOcclusionLevel = 0.7;
#else
    const float ambientOcclusionLevel = 0.0;
#endif

const float eyeBrightnessHalflife = 3.0;
const float centerDepthHalflife = 0.66;

// ========== METEOR SYSTEM CONFIGURATION ==========
#ifdef METEOR_SYSTEM
    #define METEOR_FREQUENCY 0.15 // [0.05 0.10 0.15 0.20 0.25] Frequency of meteors appearing
    #define METEOR_SPEED 2.5 // [1.0 1.5 2.0 2.5 3.0 3.5 4.0] Speed of meteor movement
    #define METEOR_LENGTH 0.8 // [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0] Length of meteor trail
    #define METEOR_BRIGHTNESS 2.2 // [1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4] Meteor brightness intensity
    #define METEOR_FADE_SPEED 1.8 // [0.8 1.0 1.2 1.4 1.6 1.8 2.0] How quickly meteors fade out
    #define METEOR_SIZE 0.025 // [0.01 0.015 0.02 0.025 0.03 0.035 0.04] Size of meteor head
    #define METEOR_TRAIL_WIDTH 0.015 // [0.005 0.01 0.015 0.02 0.025] Width of meteor trail
    
    // Meteor color schemes
    #define METEOR_COLOR_WHITE vec3(1.0, 0.9, 0.7) // Classic white/yellow meteor
    #define METEOR_COLOR_BLUE vec3(0.4, 0.7, 1.0)  // Blue meteor
    #define METEOR_COLOR_GREEN vec3(0.5, 1.0, 0.4) // Green meteor
    #define METEOR_COLOR_RED vec3(1.0, 0.5, 0.2)   // Red/orange meteor
    
    // Advanced meteor parameters
    #define METEOR_RANDOM_SEED 12345.0 // Random seed for meteor generation
    #define METEOR_MIN_ALTITUDE 0.3 // [0.1 0.2 0.3 0.4] Minimum sky altitude for meteors
    #define METEOR_MAX_ALTITUDE 0.9 // [0.6 0.7 0.8 0.9] Maximum sky altitude for meteors
    #define METEOR_NIGHT_ONLY 1 // [0 1] Show meteors only at night (1) or always (0)
#endif

// ========== CIRCULAR SUN & MOON CONFIGURATION ==========
#ifdef CIRCULAR_SUN_MOON
    #define SUN_MOON_SIZE 1.0 // [0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5] Size of sun and moon
    #define SUN_BRIGHTNESS 1.2 // [0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5] Sun brightness intensity
    #define MOON_BRIGHTNESS 0.8 // [0.4 0.5 0.6 0.7 0.8 0.9 1.0] Moon brightness intensity
    #define SUN_CORONA_SIZE 1.5 // [1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8] Sun corona glow size
    #define MOON_HALO_SIZE 1.3 // [1.0 1.1 1.2 1.3 1.4 1.5] Moon halo glow size
    #define SUN_COLOR vec3(1.0, 0.9, 0.7) // Sun color (warm yellow-white)
    #define MOON_COLOR vec3(0.9, 0.95, 1.0) // Moon color (cool blue-white)
#endif

// DH exclusive
#if defined DISTANT_HORIZONS
    #define TRANSITION_DH_SUP 0.05
    #define TRANSITION_DH_INF 0.90
#endif
