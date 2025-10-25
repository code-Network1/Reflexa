/* Reflexa - volumetric_clouds.glsl
Fast volumetric clouds - Reflexa implementation
*/

vec3 get_cloud_old(vec3 view_vector, vec3 block_color, float bright, float dither, vec3 base_pos, int samples, float umbral, vec3 cloud_color, vec3 dark_cloud_color) {
    float plane_distance;
    float cloud_value;
    float density;
    vec3 intersection_pos;
    vec3 intersection_pos_sup;
    float dif_inf;
    float dif_sup;
    float dist_aux_coeff;
    float current_value;
    float surface_inf;
    float surface_sup;
    bool first_contact = true;
    float opacity_dist;
    vec3 increment;
    float increment_dist;
    float view_y_inv = 1.0 / view_vector.y;
    float distance_aux;
    float dist_aux_coeff_blur;

    #if VOL_LIGHT == 0
        block_color.rgb *=
            clamp(bright + ((dither - .5) * .1), 0.0, 1.0) * .3 + 1.0;
    #endif

    #if defined DISTANT_HORIZONS && defined DEFERRED_SHADER
        float d_dh = texture2D(dhDepthTex0, vec2(gl_FragCoord.x / viewWidth, gl_FragCoord.y / viewHeight)).r;
        float linear_d_dh = ld_dh(d_dh);
        if (linear_d_dh < 0.9999) {
            return block_color;
        }
    #endif

    if (view_vector.y > 0.0) {  // Over horizon
        plane_distance = (CLOUD_PLANE - base_pos.y) * view_y_inv;
        intersection_pos = (view_vector * plane_distance) + base_pos;

        plane_distance = (CLOUD_PLANE_SUP - base_pos.y) * view_y_inv;
        intersection_pos_sup = (view_vector * plane_distance) + base_pos;

        dif_sup = CLOUD_PLANE_SUP - CLOUD_PLANE_CENTER;
        dif_inf = CLOUD_PLANE_CENTER - CLOUD_PLANE;
        dist_aux_coeff = (CLOUD_PLANE_SUP - CLOUD_PLANE) * 0.075;
        dist_aux_coeff_blur = dist_aux_coeff * 0.3;

        opacity_dist = dist_aux_coeff * 2.0 * view_y_inv;

        increment = (intersection_pos_sup - intersection_pos) / samples;
        increment_dist = length(increment);

        cloud_value = 0.0;

        intersection_pos += (increment * dither);

        for (int i = 0; i < samples; i++) {
            current_value =
                texture2D(
                    gaux2,
                    (intersection_pos.xz * 0.0002777777777777778) + (frameTimeCounter * CLOUD_HI_FACTOR)
                ).r;


            #if V_CLOUDS == 2 && CLOUD_VOL_STYLE == 0
                current_value +=
                    texture2D(
                        gaux2,
                        (intersection_pos.zx * 0.0002777777777777778) + (frameTimeCounter * CLOUD_LOW_FACTOR)
                    ).r;

                current_value *= 0.5;
                current_value = smoothstep(0.05, 0.95, current_value);

            #endif

            // Ajuste por umbral
            current_value = (current_value - umbral) / (1.0 - umbral);

            // Superficies inferior y superior de nubes
            surface_inf = CLOUD_PLANE_CENTER - (current_value * dif_inf);
            surface_sup = CLOUD_PLANE_CENTER + (current_value * dif_sup);

            if (  // Dentro de la nube
                intersection_pos.y > surface_inf &&
                intersection_pos.y < surface_sup
                ) {
                    cloud_value += min(increment_dist, surface_sup - surface_inf);

                    if (first_contact) {
                        first_contact = false;
                        density =
                        (surface_sup - intersection_pos.y) /
                        (CLOUD_PLANE_SUP - CLOUD_PLANE);
                    }
            }
            else if (surface_inf < surface_sup && i > 0) {  // Fuera de la nube
                distance_aux = min(
                    abs(intersection_pos.y - surface_inf),
                    abs(intersection_pos.y - surface_sup)
                );

                if (distance_aux < dist_aux_coeff_blur) {
                    cloud_value += min(
                        (clamp(dist_aux_coeff_blur - distance_aux, 0.0, dist_aux_coeff_blur) / dist_aux_coeff_blur) * increment_dist,
                        surface_sup - surface_inf
                    );

                    if (first_contact) {
                        first_contact = false;
                        density =
                        (surface_sup - intersection_pos.y) /
                        (CLOUD_PLANE_SUP - CLOUD_PLANE);
                    }
                }
            }

            intersection_pos += increment;
        }

        cloud_value = clamp(cloud_value / opacity_dist, 0.0, 1.0);
        density = clamp(density, 0.0001, 1.0);

        float att_factor = mix(1.2, 0.85 * CLOUD_BRIGHTNESS * CLOUD_CONTRAST, bright * (1.0 - rainStrength));

        // Balanced density to prevent black fog
        float enhanced_density = pow(density * CLOUD_DEPTH_MULTIPLIER * CLOUD_THICKNESS, 0.35) * CLOUD_DENSITY * CLOUD_LAYERING;
        enhanced_density = clamp(enhanced_density, 0.0, 0.85); // Prevent over-darkening
        cloud_color = mix(cloud_color * att_factor, max(dark_cloud_color * att_factor * CLOUD_SHADOW_INTENSITY, vec3(0.1)), enhanced_density);

        // Ultra-realistic sun halo with enhanced volumetric scattering
        float halo_intensity = (1.0 - pow(cloud_value, 0.15)) * bright * bright * (1.0 - rainStrength) * CLOUD_CONTRAST;
        cloud_color = mix(cloud_color, cloud_color * (15.0 * CLOUD_BRIGHTNESS), halo_intensity);

        // Maximum coverage overcast sky blending
        float depth_factor = clamp((view_vector.y - 0.02) * 7.0 * CLOUD_DEPTH_MULTIPLIER, 0.0, 1.0);
        block_color = mix(
            block_color,
            cloud_color,
            cloud_value * CLOUD_COVERAGE * CLOUD_THICKNESS * depth_factor
        );
    }

    return block_color;
}

vec3 get_cloud(vec3 view_vector, vec3 block_color, float bright, float dither, vec3 base_pos, int samples, float umbral, vec3 cloud_color, vec3 dark_cloud_color) {
    #if VOL_LIGHT == 0
        block_color.rgb *= clamp(bright + ((dither - .5) * .1), 0.0, 1.0) * .3 + 1.0;
    #endif

    #if defined DISTANT_HORIZONS && defined DEFERRED_SHADER
        float d_dh = texture2D(dhDepthTex0, gl_FragCoord.xy / vec2(viewWidth, viewHeight)).r;
        float linear_d_dh = ld_dh(d_dh);
        if (linear_d_dh < 0.9999) {
            return block_color;
        }
    #endif

    if (view_vector.y > 0.0) {  // Over horizon
        float view_y_inv = 1.0 / view_vector.y;

        float plane_distance_inf = (CLOUD_PLANE - base_pos.y) * view_y_inv;
        vec3 intersection_pos = (view_vector * plane_distance_inf) + base_pos;

        float plane_distance_sup = (CLOUD_PLANE_SUP - base_pos.y) * view_y_inv;
        vec3 intersection_pos_sup = (view_vector * plane_distance_sup) + base_pos;

        float dif_sup = CLOUD_PLANE_SUP - CLOUD_PLANE_CENTER;
        float dif_inf = CLOUD_PLANE_CENTER - CLOUD_PLANE;

        vec3 increment = (intersection_pos_sup - intersection_pos) / samples;

        float increment_dist = length(increment);
        
        float dist_aux_coeff = (CLOUD_PLANE_SUP - CLOUD_PLANE) * 0.075;
        float dist_aux_coeff_blur = dist_aux_coeff * 0.3;
        float opacity_dist = dist_aux_coeff * 2.0 * view_y_inv;

        float cloud_value = 0.0;
        float density = 0.0; // Inicializar
        bool first_contact = true;

        intersection_pos += (increment * dither);

        for (int i = 0; i < samples; i++) {
            float current_value = texture2D(gaux2, (intersection_pos.xz * 0.0002777777777777778) + (frameTimeCounter * CLOUD_HI_FACTOR)).r;

            #if V_CLOUDS == 2 && CLOUD_VOL_STYLE == 0
                current_value += texture2D(gaux2, (intersection_pos.zx * 0.0002777777777777778) + (frameTimeCounter * CLOUD_LOW_FACTOR)).r;
                current_value = smoothstep(0.05, 0.95, current_value * 0.5);
            #endif

            current_value = (current_value - umbral) / (1.0 - umbral);

            float surface_inf = CLOUD_PLANE_CENTER - (current_value * dif_inf);
            float surface_sup = CLOUD_PLANE_CENTER + (current_value * dif_sup);
            
            float current_opacity = 0.0;
            float cloud_thickness = surface_sup - surface_inf;

            if (intersection_pos.y > surface_inf && intersection_pos.y < surface_sup) {
                // Dentro de la nube
                current_opacity = min(increment_dist, cloud_thickness);
            }
            else if (cloud_thickness > 0.0 && i > 0) {
                // Cerca del borde de la nube (desenfoque)
                float distance_aux = min(abs(intersection_pos.y - surface_inf), abs(intersection_pos.y - surface_sup));
                if (distance_aux < dist_aux_coeff_blur) {
                    float blur_factor = 1.0 - (distance_aux / dist_aux_coeff_blur);
                    current_opacity = min(blur_factor * increment_dist, cloud_thickness);
                }
            }

            if (current_opacity > 0.0) {
                cloud_value += current_opacity;
                if (first_contact) {
                    first_contact = false;
                    density = (surface_sup - intersection_pos.y) / (CLOUD_PLANE_SUP - CLOUD_PLANE);
                }
            }
            
            intersection_pos += increment;
        }

        cloud_value = clamp(cloud_value / opacity_dist, 0.0, 1.0);
        density = clamp(density, 0.0001, 1.0);

        float att_factor = mix(1.2, 0.85 * CLOUD_BRIGHTNESS * CLOUD_CONTRAST, bright * (1.0 - rainStrength));

        // Balanced density optimized rendering
        float density_approx = sqrt(sqrt(density * CLOUD_DEPTH_MULTIPLIER * CLOUD_THICKNESS)) * CLOUD_DENSITY * CLOUD_LAYERING;
        density_approx = clamp(density_approx, 0.0, 0.75); // Prevent excessive darkness and black fog
        
        // Enhanced cloud color mixing without black fog
        cloud_color = mix(cloud_color * att_factor, max(dark_cloud_color * att_factor * CLOUD_SHADOW_INTENSITY, vec3(0.15)), density_approx * 0.7);

        float cloud_value_approx = sqrt(sqrt(cloud_value));
        float optimized_halo = (1.0 - cloud_value_approx) * bright * bright * (1.0 - rainStrength) * CLOUD_CONTRAST;
        cloud_color = mix(cloud_color, cloud_color * (15.0 * CLOUD_BRIGHTNESS), optimized_halo);

        float optimized_depth_factor = clamp((view_vector.y - 0.02) * 7.0 * CLOUD_DEPTH_MULTIPLIER, 0.0, 1.0);
        block_color = mix(block_color, cloud_color, cloud_value * CLOUD_COVERAGE * CLOUD_THICKNESS * optimized_depth_factor);
    }

    return block_color;
}
