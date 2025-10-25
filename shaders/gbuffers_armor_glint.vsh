#version 120
/* Reflexa - gbuffers_armor_glint.vsh
Render: Glow objects

VcorA - All Rights Reserved
*/

#define USE_BASIC_SH // Sets the use of a "basic" or "generic" shader for custom dimensions, instead of the default overworld shader. This can solve some rendering issues as the shader is closer to vanilla rendering.

#ifdef USE_BASIC_SH
    #define UNKNOWN_DIM
#endif
#define GBUFFER_ARMOR_GLINT
#define ENTITY_GLINT
#define SHADER_BASIC

#include "/common/glint_blocks_vertex.glsl"
