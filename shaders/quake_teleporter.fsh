// ----------------------------------------------------
//  "Quake Teleporter" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

const float M_PI = 3.141592;

// --------------------------------------
// Texture swirl from "Lava Pool": 
// https://www.shadertoy.com/view/XdBBDG
// --------------------------------------
float noise(in vec3 x)
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = smoothstep(0.0, 1.0, f);
    
    vec2 uv = (p.xy + vec2(37.0, 17.0) * p.z) + f.xy;
    vec2 rg = texture(iChannel1, (uv + 0.5) / 256.0, -100.0).yx;
    return mix(rg.x, rg.y, f.z) * 2.0 - 1.0;
}

vec2 swirl(in vec2 p)
{
    return vec2(noise(vec3(p.xy, .33)), noise(vec3(p.yx, .66)));
}

// ---------------------------------
//  draw the swirling portal vortex
// ---------------------------------
vec3 VortexTexture(in vec2 p)
{
    p *= vec2(0.93, -0.93);
    vec4 col = vec4(1.0);

    for(int i = 0; i < 3; i++) 
        col += texture(iChannel1, p + 0.02 * swirl(3.66 * p + iTime * 0.33)) * col * col;

    // used noise texture has only one channel
    return (col * 0.033).xxx;
}

// --------------------------------
// light and specularity functions
// --------------------------------
float VisibilityTerm(in float roughness, in float ndotv, in float ndotl)
{
    float m2    = roughness * roughness;
    float visV    = ndotl * sqrt(ndotv * (ndotv - ndotv * m2) + m2);
    float visL    = ndotv * sqrt(ndotl * (ndotl - ndotl * m2) + m2);
    return 0.5 / max(visV + visL, 0.00001);
}

float DistributionTerm(in float roughness, in float ndoth)
{
    float m2 = roughness * roughness;
    float d     = (ndoth * m2 - ndoth) * ndoth + 1.0;
    return m2 / (d * d * M_PI);
}

vec3 FresnelTerm(in vec3 specularColor, in float vdoth)
{
    return clamp(50.0 * specularColor.y, 0.0, 1.0) * specularColor + (1.0 - specularColor) * pow(1.0 - vdoth, 5.0);
}

vec3 LightSpecular(in vec3 normal, in vec3 viewDir, in vec3 lightDir, in vec3 lightColor, in float roughness, in vec3 specularColor)
{
    vec3 halfVec = normalize(viewDir + lightDir);

    float vdoth = clamp(dot(viewDir, halfVec ), 0.0, 1.0);
    float ndoth = clamp(dot(normal,     halfVec ), 0.0, 1.0);
    float ndotv = clamp(dot(normal,     viewDir ), 0.0, 1.0);
    float ndotl = clamp(dot(normal,     lightDir), 0.0, 1.0);
    
    vec3  f = FresnelTerm(specularColor, vdoth);
    float d = DistributionTerm(roughness, ndoth);
    float v = VisibilityTerm(roughness, ndotv, ndotl);
    
    return lightColor * f * (d * v * M_PI * ndotl);
}

// ---------------------------
//  signed distance functions
// ---------------------------
// see http://iquilezles.org/www/articles/distfunctions/distfunctions.htm for more!
float Box(in vec3 p, in vec3 b)
{
    vec3 d = abs(p) - b;
    return min(max(d.x, max(d.y, d.z)), 0.0) + length(max(d, 0.0));
}

float Subtract(in float a, in float b)
{
    return max(a, -b);
}

// ------------------------
//  swirling portal vortex
// ------------------------
float PortalVortex(in vec3 p)
{
    // hack for some Intel GPUs that don't render a plain box with no transformation
    return Subtract(Box(p, vec3(0.4, 0.6, 0.01)), Box(p, vec3(0.001, 0.001, 0.01)));
    //return Box(p, vec3(0.4, 0.6, 0.01));
}

// --------------------
//  outer portal frame
// --------------------
float PortalFrame(in vec3 p)
{
    return Subtract(Box(p, vec3(0.5, 0.66, 0.03)),
                    Box(p, vec3(0.35, 0.55, 0.55)));
}

// -----------
//  rotation
// -----------
mat3 rotY(in float a)
{
    return mat3(cos(a), 0.0, sin(a),
                   0.0, 1.0, 0.0,
               -sin(a), 0.0, cos(a));
}

// -------------------
//  portal raymarcher
// -------------------
#define MIN_DIST  0.001
#define MAX_DIST  3.0
#define NUM_STEPS 40
#define PORTAL_FRAME  0
#define PORTAL_VORTEX 1
float Raymarch(in vec3 from, in vec3 to, in mat3 matrix, in int objId)
{
    float dist  = MIN_DIST;
    float depth = 0.0;

    for(int i = 0; i < NUM_STEPS; ++i)
    {
        if(dist < MIN_DIST || depth > MAX_DIST) 
            break;

        if(objId == PORTAL_FRAME)
            dist = PortalFrame((from + to * depth) * matrix);
        else
            dist = PortalVortex((from + to * depth) * matrix);
        depth += dist;

        // past maximum raymarch distance - no surface hit
        if(depth > MAX_DIST)
            return 0.0;
    }

    return depth;
}

// ----------------
//  surface normal
// ----------------
vec3 SurfaceNormal(in vec3 p, in mat3 matrix, in int objId)
{
    vec3 eps = vec3( 0.001, 0.0, 0.0 );
    vec3 v1 = (p + eps.xyy) * matrix;
    vec3 v2 = (p - eps.xyy) * matrix;
    vec3 v3 = (p + eps.yxy) * matrix;
    vec3 v4 = (p - eps.yxy) * matrix;
    vec3 v5 = (p + eps.yyx) * matrix;
    vec3 v6 = (p - eps.yyx) * matrix;
    
    if(objId == PORTAL_FRAME)
    {
        return normalize(-vec3(PortalFrame(v1) - PortalFrame(v2),
                               PortalFrame(v3) - PortalFrame(v4),
                               PortalFrame(v5) - PortalFrame(v6)));
    }
    else
    {
        return normalize(-vec3(PortalVortex(v1) - PortalVortex(v2),
                               PortalVortex(v3) - PortalVortex(v4),
                               PortalVortex(v5) - PortalVortex(v6)));
    }
}

// -----------------------------
//  Quake-ish purple cloudy sky
// -----------------------------
vec3 Sky(in vec2 p)
{
    vec2 offset = vec2(0.0,0.01 * iTime);
    vec3 color  = vec3(1.0);

    for(int i = 0; i < 3; i++) 
    {
        color += mix(texture(iChannel2, p - 0.25 * offset + 0.5),
                     texture(iChannel2, 0.5 * p - offset), 
                     abs(mod(float(i) * 0.666, 2.0) - 1.0)).xyz * color * color;
    }

    return color * vec3(.0555, .0444, .0666);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv  = fragCoord.xy / iResolution.xy;
    vec2 pos = (-iResolution.xy + 2.0 * fragCoord.xy)/iResolution.y;

    // raymarch vectors and initial background pixel color
    vec3 from  = vec3(0.0, 0.0, -1.466);
    vec3 to    = normalize(vec3(pos.xy, 1.666));
    vec3 color = Sky(-uv.yx);
    vec3 lightDir = normalize(vec3(1.0 + sin(0.99 * iTime), 0.5, 1.0 + cos(0.99 * iTime)));

    // any extra rotations/shifts
    mat3 transform = mat3(1.0); //rotY(0.35 * iTime);

    int objId = PORTAL_FRAME;
    float t = Raymarch(from, to, transform, objId);
    
    if(t == 0.0)
    {
        objId = PORTAL_VORTEX;
        t = Raymarch(from, to, transform, objId);
    }

    // surface hit?
    if(t > 0.0)
    {
        vec3 p = from + t * to;
        vec3 n = SurfaceNormal(p, transform, objId);
        vec3 w = max(abs(n * transform), 0.00001);
        w /= w.x + w.y + w.z;
        
        p *= transform;

        if(objId == PORTAL_FRAME)
        {
            vec3 tx = texture(iChannel0, p.yz).xyz;
            vec3 ty = texture(iChannel0, p.xz).xyz;
            vec3 tz = texture(iChannel0, p.xy).xyz;

            vec3 tex = tx*w.x + ty*w.y + tz*w.z;
            
            // rusty color: "Quake Logo" - https://www.shadertoy.com/view/4dKXDy
            float rustMask     = clamp(tex.r * 3.0 - 0.5, 0.0, 1.0);
            float roughness    = mix(0.2, 0.6, rustMask);           
            vec3 diffuseColor  = mix(vec3( 0.0 ), tex, rustMask);
            vec3 specularColor = mix(tex, vec3(0.04), rustMask);
            vec3 lightColor    = vec3(1.6);
            vec3 diffuse = lightColor * clamp(dot(n, lightDir), 0.0, 1.0);
            
            diffuseColor *= diffuseColor * vec3(0.94, 0.72, 0.47) * 1.5;
            color = diffuseColor * (diffuse + 0.2);
            color *= clamp(abs(sin(0.77 * iTime)) + 0.44, 0.0, 1.0);
            color += LightSpecular(n, to, lightDir, lightColor, roughness, specularColor);
        }
        else
        {
            color = VortexTexture(p.yz)*w.x + 
                    VortexTexture(p.xz)*w.y + 
                    VortexTexture(p.xy)*w.z;
        }
    }

    fragColor = vec4(color, 1.0);
}
