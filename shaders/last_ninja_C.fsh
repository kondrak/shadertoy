// -------------------------------------------
//  Raster bars and loading screen background
// -------------------------------------------

#define RGB(r, g, b) vec3(float(r)/255., float(g)/255., float(b)/255.)

// C64 palette: http://unusedino.de/ec64/technical/misc/vic656x/colors/
#define NUM_COLORS 16
vec3 pal[NUM_COLORS];

// y positions for solid loading bars
float[] barY = float[] (.1, .05, .01, .07, .3, .8, .6, .56, .2, .5, .3);

// pre GLES3 GPUs don't support array constructors, so need to initialize array explicitly 
void InitPalette()
{
    pal[0]  = RGB(0, 0, 0);
    pal[1]  = RGB(255, 255, 255);
    pal[2]  = RGB(116, 67, 53);
    pal[3]  = RGB(124, 172, 186);
    pal[4]  = RGB(123, 72, 144);
    pal[5]  = RGB(100, 151, 79);
    pal[6]  = RGB(64, 50, 133);
    pal[7]  = RGB(191, 205, 122);
    pal[8]  = RGB(123, 91, 47);
    pal[9]  = RGB(79, 69, 0);
    pal[10] = RGB(163, 114, 101);
    pal[11] = RGB(80, 80, 80);
    pal[12] = RGB(120, 120, 120);
    pal[13] = RGB(164, 215, 142);
    pal[14] = RGB(120, 106, 189);
    pal[15] = RGB(159, 159, 150);
}

// loading raster bar rng
float r(in vec2 p)
{
    return fract(cos(p.x*42.98 + p.y*43.23) * 1127.53);
}


// gradient raster bar: https://www.shadertoy.com/view/Mdd3Dn
vec3 grad(float t, vec3 c1, vec3 c2, vec3 c3, vec3 c4, vec3 c5, vec3 c6, vec3 c7, vec3 c8)
{
    const float colCount = 8.;
    const float bandSize = 1./colCount;
    const float plateauSize = .8 * (bandSize * .5);
    t -= bandSize*.5;// center bands
    return
          (c1 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*0.))))
        + (c2 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*1.))))
        + (c3 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*2.))))
        + (c4 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*3.))))
        + (c5 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*4.))))
        + (c6 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*5.))))
        + (c7 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*6.))))
        + (c8 * (1.-smoothstep(plateauSize, bandSize-plateauSize, abs(t-bandSize*7.))));
}

vec3 gradGray(float t)
{
    return grad(t, pal[0], pal[11], pal[12], pal[15], pal[1], pal[15], pal[12], pal[11]);
}

vec3 gradBlue(float t)
{
    return grad(t, pal[0], pal[6], pal[14], pal[3], pal[1], pal[3], pal[14], pal[6]);
}

vec3 gradGreen(float t)
{
    return grad(t, pal[0], pal[5], pal[13], pal[3], pal[1], pal[3], pal[13], pal[5]);
}

vec3 gradBrown(float t)
{
    return grad(t, pal[0], pal[9], pal[8], pal[7], pal[1], pal[7], pal[8], pal[9]);
}

vec3 loadingBar(float t, float h, vec3 c1, vec2 uv)
{
    float b = common_BoxTest(uv, vec2(0., t), vec2(1., t + h));
    return b * c1;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord/iResolution.xy;
    vec3 c = vec3(0.);
    float barOffset = 24. * uv.y;
    InitPalette();

    // gradient rasters are displayed during initial sequence only
    if(iTime < TIME_TO_LOADER)
    {
        c += gradGray(mod(0. + barOffset, 4.));
        c += gradBlue(mod(1. + barOffset, 4.));
        c += gradGreen(mod(2.+ barOffset, 4.));
        c += gradBrown(mod(3.+ barOffset, 4.));

        if(uv.y > .906)
            c = vec3(0);
    }
    else
    {
        // pseudo random loading raster bars with cycling colors
        vec3 barC = pal[int(mod(iTime, 4.)) + 5];
        int i = int(mod(r(vec2(fract(iTime)*.0005))*10., 11.));
        c += loadingBar(barY[i], .1, barC, uv);

        barC = pal[int(mod(iTime, 2.)) + 8];
        i = 10 - int(mod(r(vec2(fract(iTime*.8)*.0004))*8., 11.));
        if(c.r == 0.)
            c += loadingBar(barY[i], .05, barC, uv);

        barC =  pal[int(mod(iTime * .8, 5.)) + 1];
        i = 10 - int(mod(r(vec2(fract(iTime*.8)*.0003))*8., 11.));
        if(c.r == 0.)
            c += loadingBar(barY[i]*1.2, .03, barC, uv);

        barC = pal[int(mod(iTime * .9, 2.)) + 14];
        i = 10 - int(mod(r(vec2(fract(iTime*.4)*.0005))*8., 11.));
        if(c.r == 0.)
            c += loadingBar(barY[i]*.9, .05, barC, uv);

        barC = pal[int(mod(iTime, 3.)) + 12];
        i = 10 - int(mod(r(vec2(fract(iTime*.5)*.0006))*8., 11.));
        if(c.r == 0.)
            c += loadingBar(barY[i]*.75, .03, barC, uv);

        barC = pal[int(mod(iTime, 15.))];
        i = 10 - int(mod(r(vec2(fract(iTime*.5)*.0002))*8., 11.));
        if(c.r == 0.)
            c += loadingBar(barY[i]*.5, .04, barC, uv);

        barC = pal[int(mod(iTime, 5.)) + 7];
        i = 10 - int(mod(r(vec2(fract(iTime*.4)*.0007))*8., 11.));
         if(c.r == 0.)
            c += loadingBar(barY[i]*1.4, .15, barC, uv);

        // fill remaining space with random color
        if(c.r == 0.)
            c = pal[int(mod(iTime *.3, 9.)) + 2];
    }

    fragColor = vec4(c, 1.);
}


