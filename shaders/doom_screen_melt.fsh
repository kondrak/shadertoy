// ----------------------------------------------------
//  "Doom Screen Melt" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

// initial "paint melt" speed
const float START_SPEED  = 2.7;
// texture melting off screen speed
const float MELT_SPEED   = 1.;
// melt effect restart interval (seconds)
const float RESTART_IVAL = 3.;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 p = uv;

    float t = mod(iTime, RESTART_IVAL);
    // flip textures every second melt
    float rt = mod(iTime, 2. * RESTART_IVAL);
    bool texFlip = rt > .0 && rt < RESTART_IVAL;

    // first let some "paint" drip before moving entire texture contents
    float d = START_SPEED * t;
    if(d > 1.) d = 1.;

    // initial paint melt shift
    p.y += d * 0.35 * fract(sin(dot(vec2(p.x, .0), vec2(12.9898, 78.233)))* 43758.5453);
    
    // now move entire melted texture offscreen
    if(d == 1.)
        p.y += MELT_SPEED * (t - d/START_SPEED);

    if(texFlip)
        fragColor = texture(iChannel0, p);
    else
        fragColor = texture(iChannel1, p);

    // draw second image behind the melting texture
    if(p.y > 1.)
    {
        if(texFlip)
            fragColor = texture(iChannel1, uv);
        else
            fragColor = texture(iChannel0, uv);
    }
}
