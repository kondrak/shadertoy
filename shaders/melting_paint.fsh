// ----------------------------------------------------
//  "Melting Paint" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

void mainImage(out vec4 o, vec2 p)
{
	p /= iResolution.xy;
    p.y += .01 * iTime * fract(sin(dot(vec2(p.x), vec2(12.9, 78.2)))* 437.5);

    o = texture(iChannel0, p);
}
