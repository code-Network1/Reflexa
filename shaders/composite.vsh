#version 120
/* Reflexa - composite.vsh
Render: Bloom and volumetric light

VcorA - All Rights Reserved
*/

#define USE_BASIC_SH // Sets the use of a "basic" or "generic" shader for custom dimensions, instead of the default overworld shader. This can solve some rendering issues as the shader is closer to vanilla rendering.

#ifdef USE_BASIC_SH
    #define UNKNOWN_DIM
#endif
#define COMPOSITE_SHADER

#include "/common/composite_vertex.glsl"
