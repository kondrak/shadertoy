// ----------------------------------------------------
//  "Matrix Pixels" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

void mainImage(out vec4 o, vec2 p)
{
    p.y /= iResolution.y;
    p.y += tan(iTime + tan(p.x) + sin(.2 * p.x));
    o = vec4(0., .3 + (p.y < 0. ? 0. : 1. - p.y * 3.), 0., 1.);
}
