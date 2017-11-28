// ---------------------------------------------
//  "Lava Pool" by Krzysztof Kondrak @k_kondrak
// ---------------------------------------------

float noise(in vec3 x)
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = smoothstep(0.0, 1.0, f);
    
    vec2 uv = (p.xy + vec2(37.0, 17.0) * p.z) + f.xy;
    vec2 rg = texture(iChannel1, (uv + 0.5) / 256.0, -100.0).yx;
    return mix(rg.x, rg.y, f.z) * 2.0 - 1.0;
}

vec2 swirl(in vec2 p)
{
    return vec2(noise(vec3(p.xy, .33)), noise(vec3(p.yx, .66)));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    fragCoord /= iResolution.y * vec2(2, -2);
    vec4 col = vec4(1.0, 0.9, 0.0, 1.0);

    for(int i = 0; i < 3; i++) 
        col += texture(iChannel0, fragCoord + 0.01 * swirl(6.66 * fragCoord + iTime * 0.33)) * col * col;

    fragColor = col * 0.066;
}
