/* Reflexa - circular_sun_moon.glsl
Circular sun and moon rendering system

VcorA - All Rights Reserved
*/

#ifdef CIRCULAR_SUN_MOON

// Note: uniforms declared in main shader files

// Calculate circular distance for sun/moon
float circularDistance(vec2 coord, vec2 center, float radius) {
    vec2 delta = coord - center;
    return length(delta) / radius;
}

// Smooth circular falloff
float smoothCircle(float dist, float edge, float smoothness) {
    return 1.0 - smoothstep(edge - smoothness, edge + smoothness, dist);
}

// Generate circular sun
vec4 renderSun(vec3 worldPos, vec3 sunDir, float dayTime, float rain) {
    if (dayTime < 0.1) return vec4(0.0); // Don't render at night
    
    // Project sun direction to screen space
    vec3 sunScreenPos = normalize(sunDir);
    
    // Calculate distance from current pixel to sun center
    vec3 pixelDir = normalize(worldPos);
    float sunDist = distance(pixelDir, sunScreenPos);
    
    // Sun size scaling
    float sunRadius = 0.04 * SUN_MOON_SIZE;
    float coronaRadius = sunRadius * SUN_CORONA_SIZE;
    
    // Main sun disk (bright center)
    float sunCore = smoothCircle(sunDist, sunRadius * 0.6, sunRadius * 0.1);
    
    // Sun edge with smooth falloff
    float sunDisk = smoothCircle(sunDist, sunRadius, sunRadius * 0.2);
    
    // Sun corona (outer glow)
    float sunCorona = smoothCircle(sunDist, coronaRadius, coronaRadius * 0.3);
    
    // Combine sun layers
    vec3 sunColor = SUN_COLOR;
    
    // Bright white core
    vec3 finalColor = mix(vec3(0.0), vec3(1.0, 1.0, 0.95) * SUN_BRIGHTNESS * 1.5, sunCore);
    
    // Warm sun color for main disk
    finalColor = mix(finalColor, sunColor * SUN_BRIGHTNESS, sunDisk * (1.0 - sunCore));
    
    // Soft corona glow
    finalColor = mix(finalColor, sunColor * SUN_BRIGHTNESS * 0.3, sunCorona * (1.0 - sunDisk));
    
    // Apply atmospheric effects
    float atmosphere = 1.0 - rain * 0.7;
    finalColor *= atmosphere;
    
    float totalIntensity = max(max(sunCore, sunDisk), sunCorona * 0.3);
    return vec4(finalColor, totalIntensity * dayTime);
}

// Generate circular moon
vec4 renderMoon(vec3 worldPos, vec3 moonDir, float nightTime, int moonPhase, float rain) {
    if (nightTime < 0.1) return vec4(0.0); // Don't render during day
    
    // Project moon direction to screen space
    vec3 moonScreenPos = normalize(moonDir);
    
    // Calculate distance from current pixel to moon center
    vec3 pixelDir = normalize(worldPos);
    float moonDist = distance(pixelDir, moonScreenPos);
    
    // Moon size scaling
    float moonRadius = 0.035 * SUN_MOON_SIZE;
    float haloRadius = moonRadius * MOON_HALO_SIZE;
    
    // Main moon disk
    float moonDisk = smoothCircle(moonDist, moonRadius, moonRadius * 0.15);
    
    // Moon halo (soft glow)
    float moonHalo = smoothCircle(moonDist, haloRadius, haloRadius * 0.4);
    
    // Moon phase effect (simple approximation)
    float phaseIntensity = 1.0 - abs(float(moonPhase) - 4.0) / 4.0;
    phaseIntensity = max(phaseIntensity, 0.3); // Minimum visibility
    
    // Combine moon layers
    vec3 moonColor = MOON_COLOR;
    
    // Moon surface with subtle texture
    float moonTexture = sin(worldPos.x * 40.0) * sin(worldPos.y * 40.0) * 0.1 + 0.9;
    vec3 finalColor = moonColor * MOON_BRIGHTNESS * moonTexture * phaseIntensity;
    
    // Apply to moon disk
    finalColor = mix(vec3(0.0), finalColor, moonDisk);
    
    // Soft halo
    vec3 haloColor = moonColor * MOON_BRIGHTNESS * 0.2;
    finalColor = mix(finalColor, haloColor, moonHalo * (1.0 - moonDisk));
    
    // Apply atmospheric effects
    float atmosphere = 1.0 - rain * 0.8;
    finalColor *= atmosphere;
    
    float totalIntensity = max(moonDisk, moonHalo * 0.2);
    return vec4(finalColor, totalIntensity * nightTime * phaseIntensity);
}

// Main function to render both sun and moon
vec4 renderCircularSunMoon(vec3 worldPos, vec3 sunDir, vec3 moonDir, 
                          float dayTime, float nightTime, int moonPhase, float rain) {
    vec4 sunResult = renderSun(worldPos, sunDir, dayTime, rain);
    vec4 moonResult = renderMoon(worldPos, moonDir, nightTime, moonPhase, rain);
    
    // Combine sun and moon (they shouldn't appear simultaneously)
    if (sunResult.a > moonResult.a) {
        return sunResult;
    } else {
        return moonResult;
    }
}

#endif
