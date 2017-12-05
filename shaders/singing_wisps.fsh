// ----------------------------------------------------
//  "Singing Wisps" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

void mainImage( out vec4 o, in vec2 p )
{
    float d = (.5 - distance(p.y, iResolution.y * .5) / iResolution.y);
    float c = 3. * d * texture(iChannel0, vec2(p.x * .03 / iResolution.x, 0.)).r;
    o = c * vec4(.85, .85, 2., 1.);
}