// ----------------------------------------------------
//  "Euclidean Palette" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

#define RGB(r, g, b) vec3(float(r)/255., float(g)/255., float(b)/255.)

// C64 palette: http://unusedino.de/ec64/technical/misc/vic656x/colors/
#define NUM_COLORS 16
vec3 palette[NUM_COLORS];

// pre GLES3 GPUs don't support array constructors, so need to initialize array explicitly 
void InitPalette()
{
    palette[0]  = RGB(0, 0, 0);
    palette[1]  = RGB(255, 255, 255);
    palette[2]  = RGB(116, 67, 53);
    palette[3]  = RGB(124, 172, 186);
    palette[4]  = RGB(123, 72, 144);
    palette[5]  = RGB(100, 151, 79);
    palette[6]  = RGB(64, 50, 133);
    palette[7]  = RGB(191, 205, 122);
    palette[8]  = RGB(123, 91, 47);
    palette[9]  = RGB(79, 69, 0);
    palette[10] = RGB(163, 114, 101);
    palette[11] = RGB(80, 80, 80);
    palette[12] = RGB(120, 120, 120);
    palette[13] = RGB(164, 215, 142);
    palette[14] = RGB(120, 106, 189);
    palette[15] = RGB(159, 159, 150);
}

// find nearest palette color using Euclidean distance
vec4 EuclidDist(vec3 c, vec3[NUM_COLORS] pal)
{
    int idx = 0;
    float nd = distance(c, pal[0]);

    for(int i = 1; i < NUM_COLORS; i++)
    {
        float d = distance(c, pal[i]);
        
        if(d < nd)
        {
            nd = d;
            idx = i;
        }
    }

    // older GPUs/drivers require constant array indexing, so can't use idx directly
    if(idx == 0)  return vec4(pal[0], 1.);
    if(idx == 1)  return vec4(pal[1], 1.);
    if(idx == 2)  return vec4(pal[2], 1.);
    if(idx == 3)  return vec4(pal[3], 1.);
    if(idx == 4)  return vec4(pal[4], 1.);
    if(idx == 5)  return vec4(pal[5], 1.);
    if(idx == 6)  return vec4(pal[6], 1.);
    if(idx == 7)  return vec4(pal[7], 1.);
    if(idx == 8)  return vec4(pal[8], 1.);
    if(idx == 9)  return vec4(pal[9], 1.);
    if(idx == 10) return vec4(pal[10], 1.);
    if(idx == 11) return vec4(pal[11], 1.);
    if(idx == 12) return vec4(pal[12], 1.);
    if(idx == 13) return vec4(pal[13], 1.);
    if(idx == 14) return vec4(pal[14], 1.);
    return vec4(pal[15], 1.);

    // sleek but not guaranteed to work on older GPUs!
    //return vec4(pal[idx], 1.);
}

void mainImage(out vec4 o, in vec2 p)
{
    vec2 uv = vec2(floor(p.x * .25) * 4., floor(p.y * .5) * 2.) / iResolution.xy;
    InitPalette();

    if(iResolution.y - p.y < iTime * 100.)
        o = EuclidDist(texture(iChannel0, uv).rgb, palette);
    else
        o = vec4(RGB(120, 105, 189), 1.);
}