// ----------------------------------------------------
//  "Color Eraser" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

// show current eraser mask?
#define RENDER_MASK 0

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;

    vec4 color = texture(iChannel0, uv);
    float mask = texture(iChannel1, uv).r;

    // use the coefficients for sRGB monitors
    vec4 grayScale = vec4(vec3(dot(color.rgb, vec3(0.2126, 0.7152, 0.0722))), 1.);

#if RENDER_MASK
    fragColor = texture(iChannel1, uv);
#else
    fragColor = mix(color, grayScale, clamp(mask, 0., 1.));
#endif
}

// *** Buffer A ***

// color eraser mask + soft mask painter based on https://www.shadertoy.com/view/4d2cDz

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);

    float n = (iMouse.z < .5) ? 100. : 1.;
    float d = length(fragCoord.xy - iMouse.xy) * n;  
    float a = 1.0 - min(d / 50., 1.);

    fragColor += vec4(.2 * a);
}