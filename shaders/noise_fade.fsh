// -----------------------------------------------------
//  "Simple Noise Fade" by Krzysztof Kondrak @k_kondrak
// -----------------------------------------------------

float r(in vec2 p)
{
    return fract(cos(p.x*42.98 + p.y*43.23) * 1127.53);
}

// using noise functions from: https://www.shadertoy.com/view/XtXXD8
float n(in vec2 p)
{
    vec2 fn = floor(p);
    vec2 sn = smoothstep(vec2(0), vec2(1), fract(p));
    
    float h1 = mix(r(fn), r(fn + vec2(1,0)), sn.x);
    float h2 = mix(r(fn + vec2(0,1)), r(fn + vec2(1)), sn.x);
    return mix(h1 ,h2, sn.y);
}

float noise(in vec2 p)
{
    return n(p/32.) * 0.58 +
           n(p/16.) * 0.2  +
           n(p/8.)  * 0.1  +
           n(p/4.)  * 0.05 +
           n(p/2.)  * 0.02 +
           n(p)     * 0.0125;
}

void mainImage(out vec4 c, in vec2 p)
{
    vec2 uv = p/iResolution.xx;
    float t = abs(sin(iTime));

    // fade to black
    c = mix(texture(iChannel0, uv), vec4(0), smoothstep(t + .1, t - .1, noise(p * .4)));
}