/* Reflexa - meteor_system.glsl
Beautiful falling meteor system with realistic trails and effects

VcorA - All Rights Reserved
*/

#ifdef METEOR_SYSTEM

// Noise function for meteor generation
float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * METEOR_RANDOM_SEED);
    p3 += dot(p3, p3.yzx + 19.19);
    return fract((p3.x + p3.y) * p3.z);
}

float hash13(vec3 p) {
    p = fract(p * 0.1031);
    p += dot(p, p.yzx + 33.33);
    return fract((p.x + p.y) * p.z);
}

// Generate meteor data
vec4 generateMeteor(vec2 coord, float time, float night_intensity) {
    #if METEOR_NIGHT_ONLY == 1
        if (night_intensity < 0.3) return vec4(0.0);
    #endif
    
    vec2 grid = floor(coord * 8.0); // Divide sky into grid
    vec2 local = fract(coord * 8.0);
    
    // Time-based meteor cycling
    float cycle_time = time * METEOR_SPEED * 0.1;
    float meteor_seed = hash12(grid + floor(cycle_time));
    
    // Check if this grid cell should have a meteor
    if (meteor_seed > METEOR_FREQUENCY) return vec4(0.0);
    
    // Meteor timing within cycle
    float local_time = fract(cycle_time + meteor_seed * 10.0);
    if (local_time > 1.0) return vec4(0.0);
    
    // Meteor path parameters
    vec2 start_pos = vec2(hash12(grid + 1.0), hash12(grid + 2.0));
    vec2 direction = normalize(vec2(hash12(grid + 3.0) - 0.5, -(0.3 + hash12(grid + 4.0) * 0.4)));
    
    // Current meteor position
    vec2 meteor_pos = start_pos + direction * local_time * METEOR_LENGTH;
    
    // Distance from fragment to meteor
    vec2 to_meteor = local - meteor_pos;
    float dist_to_path = abs(dot(to_meteor, vec2(-direction.y, direction.x)));
    float dist_along_path = dot(to_meteor, -direction);
    
    // Meteor head
    float head_dist = length(local - meteor_pos);
    float head_intensity = 1.0 - smoothstep(0.0, METEOR_SIZE, head_dist);
    
    // Meteor trail
    float trail_intensity = 0.0;
    if (dist_along_path > 0.0 && dist_along_path < METEOR_LENGTH * 0.6) {
        float trail_fade = 1.0 - (dist_along_path / (METEOR_LENGTH * 0.6));
        trail_intensity = (1.0 - smoothstep(0.0, METEOR_TRAIL_WIDTH, dist_to_path)) * trail_fade;
    }
    
    // Overall meteor intensity
    float meteor_intensity = max(head_intensity, trail_intensity * 0.7);
    
    // Fade out effect
    float fade_factor = 1.0 - pow(local_time, METEOR_FADE_SPEED);
    meteor_intensity *= fade_factor;
    
    // Apply night intensity
    meteor_intensity *= night_intensity;
    
    if (meteor_intensity < 0.01) return vec4(0.0);
    
    // Color selection based on position
    vec3 meteor_color;
    float color_choice = hash12(grid + 5.0);
    
    if (color_choice < 0.5) {
        meteor_color = METEOR_COLOR_WHITE;
    } else if (color_choice < 0.7) {
        meteor_color = METEOR_COLOR_BLUE;
    } else if (color_choice < 0.85) {
        meteor_color = METEOR_COLOR_GREEN;
    } else {
        meteor_color = METEOR_COLOR_RED;
    }
    
    // Enhanced brightness for head
    if (head_intensity > 0.1) {
        meteor_color *= METEOR_BRIGHTNESS * 1.5; // Brighter head
    } else {
        meteor_color *= METEOR_BRIGHTNESS; // Normal trail
    }
    
    return vec4(meteor_color * meteor_intensity, meteor_intensity);
}

// Main meteor rendering function
vec4 renderMeteorSystem(vec2 sky_coord, float time, float night_intensity) {
    vec4 meteor_result = vec4(0.0);
    
    // Generate meteors at different scales for variety
    meteor_result += generateMeteor(sky_coord, time, night_intensity);
    meteor_result += generateMeteor(sky_coord * 0.7 + vec2(0.3, 0.1), time * 0.8, night_intensity) * 0.8;
    meteor_result += generateMeteor(sky_coord * 1.3 + vec2(0.7, 0.4), time * 1.2, night_intensity) * 0.6;
    
    // Clamp to prevent over-brightness
    meteor_result.rgb = clamp(meteor_result.rgb, vec3(0.0), vec3(3.0));
    meteor_result.a = clamp(meteor_result.a, 0.0, 1.0);
    
    return meteor_result;
}

#endif
