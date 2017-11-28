// ----------------------------------------------------
//  "No Signal" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

void mainImage(out vec4 c, in vec2 p)
{
    float r = fract(cos(p.x*42.98 + p.y*43.23) * 1427.53) * iTime;
    c = vec4(.5 * r * sin(45. * r));
}
