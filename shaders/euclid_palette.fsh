// ----------------------------------------------------
//  "Euclidean Palette" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

#define RGB(r, g, b) vec3(float(r)/255., float(g)/255., float(b)/255.)

// C64 palette: http://unusedino.de/ec64/technical/misc/vic656x/colors/
#define NUM_COLORS 16
vec3 palette[NUM_COLORS] = vec3[](RGB(0, 0, 0),
                                  RGB(255, 255, 255),
                                  RGB(116, 67, 53),
                                  RGB(124, 172, 186),
                                  RGB(123, 72, 144),
                                  RGB(100, 151, 79),
                                  RGB(64, 50, 133),
                                  RGB(191, 205, 122),
                                  RGB(123, 91, 47),
                                  RGB(79, 69, 0),
                                  RGB(163, 114, 101),
                                  RGB(80, 80, 80),
                                  RGB(120, 120, 120),
                                  RGB(164, 215, 142),
                                  RGB(120, 106, 189),
                                  RGB(159, 159, 150)
                                  );

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

    return vec4(pal[idx], 1.);
}

void mainImage(out vec4 o, in vec2 p)
{
    vec2 uv = vec2(floor(p.x * .25) * 4., floor(p.y * .5) * 2.) / iResolution.xy;

    if(iResolution.y - p.y < iTime * 100.)
        o = EuclidDist(texture(iChannel0, uv).rgb, palette);
    else
        o = vec4(RGB(120, 105, 189), 1.);
}