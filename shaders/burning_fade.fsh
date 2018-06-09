// --------------------------------------------------------
//  "Burning Texture Fade" by Krzysztof Kondrak @k_kondrak
// --------------------------------------------------------

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

// smokey-hellish background
vec3 background(in vec2 pos)
{
    vec2 offset = vec2(0.0,0.01 * iTime);
    vec3 color  = vec3(1.0);

    for(int i = 0; i < 3; i++) 
    {
        color += mix(texture(iChannel1, pos - 0.25 * offset + 0.5),
                     texture(iChannel1, pos - offset), 
                     abs(mod(float(i) * 0.666, 2.0) - 1.0)).xyz * color * color;
    }

    return color * vec3(.0666, .0266, .00333);
}


void mainImage(out vec4 c, in vec2 p)
{
    vec2 uv = p/iResolution.xx;

    float t = mod(iTime*.15, 1.2);

    // fade to black
    c = mix(texture(iChannel0, uv), vec4(0), smoothstep(t + .1, t - .1, noise(p * .4)));
    
    // burning on the edges (when c.a < .1)
    c.rgb = clamp(c.rgb + step(c.a, .1) * 1.6 * noise(2000. * uv) * vec3(1.2,.5,.0), 0., 1.);

    // fancy background under burned texture
    c.rgb = c.rgb * step(.01, c.a) + background(.1 * uv) * step(c.a, .01); 
    
    // alternatively
    //  if(c.a < .01)
    //     c = background(.1 * uv);
    
    // plain burn-to-black
    // c.rgb *= step(.01, c.a);
}