// ----------------------------------------------------------------------------------
// Raymarched 1996 Quake's "Pentagram of Protection" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------------------------------------

const float M_PI = 3.141592;

// ---------------------------
//  signed distance functions
// ---------------------------
// see http://iquilezles.org/www/articles/distfunctions/distfunctions.htm for more!
float Box(in vec3 p, in vec3 b)
{
    vec3 d = abs(p) - b;
    return min(max(d.x, max(d.y, d.z)), 0.0) + length(max(d, 0.0));
}

float Cylinder(in vec3 p, in float r, in float h) 
{
    return max(length(p.xz) - r, abs(p.y) - h);
}

float Subtract(in float a, in float b)
{
    return max(a, -b);
}

float Union(in float d1, in float d2)
{
    return min(d1, d2);
}

float Intersect(in float d1, in float d2)
{
    return max(d1, d2);
}

// -----------
//  rotation
// -----------
mat3 rotX(in float a)
{
    return mat3(1.0,    0.0,  0.0,
                0.0, cos(a), -sin(a),
                0.0, sin(a),  cos(a));
}

mat3 rotY(in float a)
{
    return mat3(cos(a), 0.0, sin(a),
                   0.0, 1.0, 0.0,
               -sin(a), 0.0, cos(a));
}

mat3 rotZ(in float a)
{
    return mat3(cos(a), -sin(a), 0.0,
                sin(a),  cos(a), 0.0,
                   0.0,     0.0, 1.0);      
}

// -------------------------
//  draw hellish background
// -------------------------
vec3 Background(in vec2 pos)
{
    vec2 offset = vec2(0.0,0.01 * iTime);
    vec3 color  = vec3(1.0);

    for(int i = 0; i < 3; i++) 
    {
        color += mix(texture(iChannel1, pos - 0.25 * offset + 0.5),
                     texture(iChannel1, pos - offset), 
                     abs(mod(float(i) * 0.666, 2.0) - 1.0)).xyz * color * color;
    }

    return color * vec3(.0666, .0444, .00444);
}

// ---------------------------
//  SDF pentagram composition
// ---------------------------
float Pentagram(in vec3 p)
{
    // pentagram octagonal frame
    mat3 r1 = rotZ(0.12 * M_PI);
    mat3 r2 = rotZ(0.38 * M_PI);
    float a = Box(p * r1, vec3(0.6, 0.6, 0.15));
    float b = Box(p * r2, vec3(0.6, 0.6, 0.15));
    float c = Box(p * r1, vec3(0.7, 0.7, 0.05));
    float d = Box(p * r2, vec3(0.7, 0.7, 0.05));

    float frame = Subtract(Intersect(c, d), Intersect(a, b));

    // inside of the pentagram
    vec3 offset = vec3(0.22, 0.0, 0.0);
    float star  = Cylinder( p * rotZ(-0.5 * M_PI) + vec3(0.17, 0.0, 0.0), 0.04, 0.61);
    star = Union(star, Cylinder(p * rotZ(0.115 * M_PI) - offset, 0.04, 0.61 ));
    star = Union(star, Cylinder(p * rotZ(-.115 * M_PI) + offset, 0.04, 0.61 ));
    star = Union(star, Cylinder(p * rotZ(-0.68 * M_PI) - offset, 0.04, 0.61 ));
    star = Union(star, Cylinder(p * rotZ(-0.32 * M_PI) - offset, 0.04, 0.61 ));

    return Union(frame, star);
}

// ----------------
//  surface normal
// ----------------
vec3 SurfaceNormal(in vec3 pos, in mat3 matrix)
{
    vec3 eps = vec3( 0.001, 0.0, 0.0 );
    return normalize(-vec3(Pentagram((pos + eps.xyy) * matrix) - Pentagram((pos - eps.xyy) * matrix),
                           Pentagram((pos + eps.yxy) * matrix) - Pentagram((pos - eps.yxy) * matrix),
                           Pentagram((pos + eps.yyx) * matrix) - Pentagram((pos - eps.yyx) * matrix)));
}

// ----------------------
//  pentagram raymarcher
// ----------------------
#define MIN_DIST  0.001
#define MAX_DIST  3.0
#define NUM_STEPS 50
float Raymarch(in vec3 from, in vec3 to, in mat3 matrix)
{
    float dist  = MIN_DIST;
    float depth = 0.0;

    for(int i = 0; i < NUM_STEPS; ++i)
    {
        if(dist < MIN_DIST || depth > MAX_DIST) 
            break;

        dist  = Pentagram((from + to * depth) * matrix);
        depth += dist;

        // past maximum raymarch distance - no surface hit
        if(depth > MAX_DIST)
            return 0.0;
    }

    return depth;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    float ratio = iResolution.x / iResolution.y;
    vec2 uv  = fragCoord.xy / iResolution.xy;
    vec2 pos = 2.0 * uv - 1.0;
    vec2 bgPos = uv * vec2(0.0666);
    pos.x   *= ratio;
    bgPos.x *= ratio;

    // raymarch vectors and initial background pixel color
    vec3 from  = vec3(0.0, 0.0, -1.666);
    vec3 to    = normalize(vec3(pos.xy, 1.666));
    vec3 color = Background(bgPos);

    // pentagram rotation
    mat3 transform = rotY(iTime);

    float t = Raymarch(from, to, transform);

    // surface hit?
    if(t > 0.0)
    {
        vec3 p = from + t * to;
        vec3 n = SurfaceNormal(p, transform);

        vec3 tx = texture(iChannel0, p.yz + 0.1666 * iTime).xyz * n.x * 4.666;
        vec3 ty = texture(iChannel0, p.xz + 0.2666 * iTime).xyz * n.y * 3.666;
        vec3 tz = texture(iChannel0, p.xy + 0.3666 * iTime).xyz * n.z * 2.666;

        // BLOOD!
        color.r  = clamp((tx + ty + tz) * 0.333, 0.0, 1.0).r;
        color.gb = vec2(0.0);
    }

    fragColor = vec4(color, 1.0);
}
