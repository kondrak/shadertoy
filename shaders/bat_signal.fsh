// ----------------------------------------------------
//  "Bat Signal" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

// ----------------------------------------------------------------
//  modified "Batman Logo" - https://www.shadertoy.com/view/ldXSDB
// ----------------------------------------------------------------
float ellipse(in vec2 p, in float x, in float y, in float dirx, in float diry, in float radx, in float rady)
{
    vec2  q = p - vec2(x, y);
    float u = dot( q, vec2(dirx, diry));
    float v = dot( q, vec2(diry, dirx) * vec2(-1.0, 1.0));
    return dot(vec2(u*u, v*v),vec2(1.0/(radx*radx), 1.0/(rady*rady))) - 1.0;
}

float box(in vec2 p, in float x, in float y, in float dirx, in float diry, in float radx, in float rady)
{
    vec2  q = p - vec2(x, y);
    float u = dot( q, vec2(dirx, diry));
    float v = dot( q, vec2(diry, dirx) * vec2(-1.0, 1.0));
    vec2  d = abs(vec2(u, v)) - vec2(radx, rady);
    return max(d.x, d.y);
}

float fillEllipse(in vec2 p, in float x, in float y, in float dirx, in float diry, in float radx, in float rady)
{
    float d = ellipse(p, x, y ,dirx, diry, radx, rady);
    float w = fwidth(d);
    return 1.0 - smoothstep( -w, w, d);
}

float fillRectangle(in vec2 p, in float x, in float y, in float dirx, in float diry, in float radx, in float rady)
{
    float d = box(p, x, y, dirx, diry, radx, rady);
    float w = fwidth(d);
    return 1.0 - smoothstep( -w, w, d);
}

float BatLogo(in vec2 p)
{
    p.x = abs(p.x);
    p.x *= 1.0 + 0.05 * p.x * sin(2.0 * iTime + 0.0);
    p.y *= 1.0 + 0.05 * p.x * sin(2.0 * iTime + 1.3);    
    
    float f = 1.0;
    
    f = mix( f, 0.0,     fillEllipse(   p, 0.000, 0.000,  1.0, 0.0, 0.500, 0.488) );
    f = mix( f, 1.0,     fillEllipse(   p, 0.188, 0.300,  1.0, 0.0, 0.089, 0.167) );
    f = mix( f, 1.0,     fillRectangle( p, 0.170, 0.400,  1.0, 0.0, 0.070, 0.100) );
    f = mix( f, 1.0,     fillRectangle( p, 0.000, 0.460,  1.0, 0.0, 0.040, 0.100) );
    f = mix( f, 1.0,     fillRectangle( p, 0.036, 0.448,  0.6, 0.8, 0.065, 0.057) );
    f = mix( f, 1.0,     fillEllipse(   p, 0.095,-0.450,  1.0, 0.0, 0.097, 0.333) );
    f = mix( f, 1.0,     fillEllipse(   p, 0.180,-0.350, -1.0, 0.5, 0.100, 0.278) );
    f = mix( f, 0.0, 1.0-fillEllipse(   p, 0.000, 0.000,  1.0, 0.0, 0.550, 0.550) );

    return f;
}

// --------------------
//  sold spotlight ray
// --------------------
float Spotlight(in vec2 p)
{
    vec2 q = p;
    q.x = abs(q.x);
    q.x *= 1.0 + 0.05 * q.x * sin(2.0 * iTime + 0.0);
    q.y *= 1.0 + 0.05 * q.x * sin(2.0 * iTime + 1.3);
    float r = mix( 1.0, 0.0, 1.0-fillEllipse(q, 0.000, 0.000,  1.0, 0.0, 0.550, 0.550) );
    float f = 1.0;
    
    f = mix(f, 0.0, 1.0-fillRectangle( p, 0.75, -0.5,  -0.015, 0.01, 0.045, 0.00975) );
    f = mix(f, 0.0, r);
    f = mix(f, 0.0, fillRectangle( p, -0.75, 0.5,  -0.015, 0.01, 0.0175, 0.00995) );
    f = mix(f, 1.0, r);
    f = mix(f, 0.0, fillRectangle( p, 1.335, 0.05,  -0.013, 0.015, 0.07, 0.00975) );

    return f;
}

// ----------------------
//  spotlight "god rays"
// ----------------------
float SpotRays(in vec2 raySrc, in vec2 rayDir, in vec2 pos, in float speed)
{
    float cosAngle = dot(normalize(pos - raySrc), rayDir);
    
    return clamp(0.75 + 0.2  * sin( cosAngle * 66.22 + iTime * speed) +
                      + 0.15 * cos(-cosAngle * 43.11 + iTime * speed), 0.0, 1.0) *
                      clamp((pos.x - length(pos - raySrc)) / pos.x, 0.5, 1.0);
}

// -----------
//  night sky
// -----------
vec3 Sky(in vec2 pos)
{
    vec2 offset = vec2(0.004*iTime,0.0);
    vec3 color  = vec3(1.0);

    for(int i = 0; i < 3; i++) 
    {
        color += mix(texture(iChannel0, pos - 0.25 * offset + 0.5),
                     texture(iChannel0, pos - offset), 
                     abs(mod(float(i) * 0.666, 2.0) - 1.0)).xyz * color * color;
    }

    return color * vec3(.0111, 0.0111, .06);
}


// --------------------------
//  Bat Signal - ray + symbol
// --------------------------
vec3 BatSignal(in vec2 uv, in vec2 pos, in float scale, in vec3 bgColor)
{
    vec2 rayOffset = vec2(2.6, -2.3);
    vec2 p  = (uv + pos) * scale;
    float f = 0.5 * BatLogo(p) + 0.2 * Spotlight(p);
    f *= bgColor.x + bgColor.y + bgColor.z;
        
    return vec3(f) * SpotRays(pos, normalize(vec2(1.0, -0.11)), -uv + rayOffset/scale, 1.5);
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = (-iResolution.xy + 2.0 * fragCoord.xy)/iResolution.y;
    vec3 color = Sky(p * 0.0322);

    color += BatSignal(p, vec2(0.55, -0.35), 1.1, color) * 3.5;

    fragColor = vec4(color, 1.0);
}
