// ---------------------------------------------------------
//  "Last Ninja C64 Loader" by Krzysztof Kondrak @k_kondrak
// ---------------------------------------------------------

// Buf A - Ninja face and title
// Buf B - borders, texts and HUD
// Buf C - raster bars and loading background

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec2 uv2 = uv;

    uv.y -= .1 * iTime - 1.;
    if(iTime > SCROLL_DURATION)
        uv.y = uv2.y;

    vec3 bgColor  = texture(iChannel3, uv2).rgb;
    vec3 boxColor = (texture(iChannel1, uv) + texture(iChannel2, uv)).rgb;

    vec4 startBox = vec4(0., 0., 1., .906);
    vec4 finalBox = vec4(0.1425, 0.1055, .847, .906);

    float t = 0.;

    if(iTime > TIME_TO_LOADER)
        t = common_BoxTest(uv, vec2(finalBox.xy), vec2(finalBox.zw));
    else
        t = common_BoxTest(uv, vec2(startBox.xy), vec2(startBox.zw));

    fragColor = vec4(t * boxColor + (1. - t) * bgColor, 1.);
}