// ----------------------------------------------------
//  "The One Ring Revisited" by Krzysztof Kondrak @k_kondrak
// ----------------------------------------------------

// enable/disable AA
#define ANTIALIASING 1
#define AA_SAMPLES 2
#define AA_WIDTH .8

#define FOV 5.5
#define RING_RADIUS 1.5

// raymarching constants
#define MIN_DIST  .001
#define MAX_DIST  30.
#define NUM_STEPS 100
#define BACKGROUND_ID 0
#define RING_ID       1

// Gold color: https://www.shadertoy.com/view/XdVSRV
const vec3 GOLD1 = vec3(1.1,  0.91, 0.52);
const vec3 GOLD2 = vec3(1.1,  1.07, 0.88);
const vec3 GOLD3 = vec3(1.02, 0.82, 0.55);

// texture mapping parameters for text positioning
const float vMin = -0.45;
const float vMax = 0.45;

// initial eye/camera position
vec3 EYE = vec3(7.5, 0., 0.);

// helper struct to collect raymarching data
struct RMInfo
{
    vec3 pos;
    vec3 normal;
    int  objId;
};

// ------------------
//  1D hash function
// ------------------
float hash(float n)
{
    return fract(sin(n)*753.5453123);
}

// ----------------------------------------------
//  noise: https://www.shadertoy.com/view/4sfGzS
// ----------------------------------------------
float noise(vec3 x)
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f * f * (3.0 - 2.0 * f);

    float n = p.x + p.y * 157.0 + 113.0 * p.z;
    return mix(mix(mix(hash(n +   0.0), hash(n +   1.0), f.x),
                   mix(hash(n + 157.0), hash(n + 158.0), f.x), f.y),
               mix(mix(hash(n + 113.0), hash(n + 114.0), f.x),
                   mix(hash(n + 270.0), hash(n + 271.0), f.x), f.y), f.z);
}

// -----------------
//  vector rotation
// -----------------
vec2 rotate(vec2 v, float a)
{
    return vec2(v.x * cos(a) - v.y * sin(a), v.x * sin(a) + v.y * cos(a));
}


// ----------------------------------------------------------
//  Elvish characters: https://www.shadertoy.com/view/MtS3RK
// ----------------------------------------------------------
struct EL
{
    float x, y, rx, ry, dx, dy;
};

mat3 myInverse( mat3 m )
{
    mat3 res;
    res[0][0] = m[0][0];
    res[0][1] = m[1][0];
    res[1][0] = m[0][1];
    res[1][1] = m[1][1];
    vec2 t = mat2( res ) * vec2( -m[2][0], -m[2][1] );
    res[2] = vec3( t, 1.0 );
    return res;
}

float toEL( in vec2 v, in EL el )
{
    mat3 m = mat3(
        el.dx, el.dy, 0.0,
        -el.dy, el.dx, 0.0,
        el.x, el.y, 1.0 );
    mat3 mi = myInverse( m );

    vec2 t = ( mi * vec3( v, 1.0 ) ).xy;
    return t.x * t.x / ( el.rx * el.rx ) + t.y * t.y / ( el.ry * el.ry ) - 1.0;
}

float toDash1( vec2 uv )
{
    EL ael[12];
    ael[0] = EL( 110.0, 117.0, 8.8, 200.3, 0.966, -0.259 );
    ael[1] = EL( 90.0, 39.0, 72.2, 242.6, 0.966, -0.259 );
    ael[2] = EL( 161.0, 306.0, 5.0, 11.0, 0.966, -0.259 );
    ael[3] = EL( 152.0, 278.0, 4.0, 6.0, 1.000, 0.000 );
    ael[4] = EL( 32.0, 276.0, 112.0, 118.0, 1.000, 0.000 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = min( d, toEL( uv, ael[3] ) );
    return d;
}

float toDash3( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 32.0, 276.0, 112.0, 118.0, 1.000, 0.000 );
    ael[1] = EL( -17.0, 250.0, 159.0, 163.0, 1.000, 0.000 );
    ael[2] = EL( 65.0, 362.0, 100.0, 100.0, 1.000, 0.000 );
    ael[3] = EL( 138.0, 296.0, 4.3, 12.3, 0.966, 0.259 );
    ael[4] = EL( 243.0, 207.0, 100.0, 126.5, 0.940, -0.342 );
    ael[5] = EL( 238.0, 140.0, 125.4, 193.2, 0.951, -0.309 );
    ael[6] = EL( 278.0, 295.0, 100.0, 100.0, 1.000, 0.000 );
    ael[7] = EL( 180.0, 283.0, 5.7, 9.8, 0.866, -0.500 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = max( d, -toEL( uv, ael[2] ) );
    d = min( d, toEL( uv, ael[3] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    d = max( d, -toEL( uv, ael[6] ) );
    d = min( d, toEL( uv, ael[7] ) );
    d = min( d, toDash1( uv ) );
    return d;    
}

float toCharC( vec2 uv )
{
    float d = toEL( uv, EL( 106.0, 102.0, 76.0, 100.0, 0.96, -0.25 ) );
    d = max( d, -toEL( uv, EL( 118.0, 105.0, 71.0, 90.0, 0.97, -0.20 ) ) );
    d = min( d, toEL( uv, EL( 151.0, 177.0, 10.4, 15.8, -0.788, -0.615 ) ) );
    return d;
}

float toCharC1( vec2 uv )
{
    float d = toEL( uv, EL( 98.0, 100.0, 78.8, 105.5, 0.866, -0.500 ) );
    d = max( d, -toEL( uv, EL( 88.0, 94.0, 70.0, 95.4, 0.858, -0.513 ) ) );
    d = min( d, toEL( uv, EL( 46.0, 22.0, 12.0, 19.8, 0.755, 0.656 ) ) );
    return d;
}

float toCharp( vec2 uv )
{
    float d = toEL( uv, EL( -303.0, 201.0, 357.0, 379.0, 1.0, 0.0 ) );
    d = max( d, -toEL( uv, EL( -353.0, 218.0, 410.0, 408.0, 1.0, 0.0 ) ) );
    d = min( d, toEL( uv, EL( 389.0, 21.0, 359.0, 351.0, 1.0, 0.0 ) ) );
    d = max( d, -toEL( uv, EL( 435.0, -16.0, 411.0, 404.0, 1.0, 0.0 ) ) );
    d = min( d, toEL( uv, EL( 145.0, 100.0, 100.0, 100.0, 1.0, 0.0 ) ) );
    d = max( d, -toEL( uv, EL( 182.0, 90.0, 139.0, 112.0, 1.0, 0.0 ) ) );
    d = min( d, toEL( uv, EL( 95.0, 68.0, 49.0, 141.0, 0.92, -0.39 ) ) );
    d = max( d, -toEL( uv, EL( 71.0, 28.0, 51.5, 180.2, 0.92, -0.39 ) ) );
    return d;
}

float toCharZ( vec2 uv )
{
    EL ael[4];
    ael[0] = EL( 100.0, 86.0, 87.4, 123.6, 0.799, -0.602 );
    ael[1] = EL( 67.0, 66.0, 81.6, 147.1, 0.719, -0.695 );
    ael[2] = EL( 65.0, -174.0, 100.0, 194.2, 0.819, -0.574 );
    ael[3] = EL( 41.0, -173.0, 104.4, 194.5, 0.739, -0.674 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    return d;
}

float toCharw( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 120.0, -80.0, 74.8, 359.8, 0.875, -0.485 );
    ael[1] = EL( 117.0, -50.0, 81.7, 390.5, 0.883, -0.469 );
    ael[2] = EL( 95.0, 101.0, 66.5, 103.5, 0.940, -0.342 );
    ael[3] = EL( 109.0, 117.0, 52.8, 95.3, 0.914, -0.407 );
    ael[4] = EL( 215.0, 101.0, 66.8, 103.1, 0.940, -0.342 );
    ael[5] = EL( 224.0, 116.0, 52.6, 95.7, 0.914, -0.407 );
    ael[6] = EL( 385.0, 136.0, 100.0, 100.0, 1.000, 0.000 );
    ael[7] = EL( 388.0, 108.0, 100.0, 146.7, 0.966, -0.259 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    d = min( d, toEL( uv, ael[6] ) );
    d = max( d, -toEL( uv, ael[7] ) );
    return d;
}

float toCharTilda( vec2 uv )
{
    EL ael[3];
    ael[0] = EL( 255.0, -7.0, 619.0, 209.0, 1.000, 0.000 );
    ael[1] = EL( 116.0, -43.0, 1030.2, 229.2, 0.999, 0.052 );
    ael[2] = EL( 301.0, 125.0, 371.9, 66.7, 0.974, 0.225 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = max( d, -toEL( uv, ael[2] ) );
    return d;
}

float toCharj( vec2 uv )
{
    EL ael[2];
    ael[0] = EL( -63.0, -82.0, 83.0, 329.0, 0.848, -0.530 );
    ael[1] = EL( -98.0, -106.0, 88.7, 340.7, 0.829, -0.559 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    return d;
}

float toCurl( vec2 uv )
{
    EL ael[7];
    ael[0] = EL( 204.0, 181.0, 100.0, 271.1, 0.904, -0.428 );
    ael[1] = EL( 191.0, 148.0, 92.6, 277.2, 0.912, -0.409 );
    ael[2] = EL( 284.0, 301.0, 60.0, 60.0, 1.000, 0.000 );
    ael[3] = EL( 391.0, 38.0, 146.0, 302.2, 0.978, -0.208 );
    ael[4] = EL( 288.0, 317.0, 45.0, 67.3, 0.996, -0.087 );
    ael[5] = EL( 256.0, 335.0, 17.0, 16.0, 1.000, 0.000 );
    ael[6] = EL( 110.0, 99.0, 100.0, 100.0, 1.000, 0.000 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = max( d, -toEL( uv, ael[4] ) );
    d = min( d, toEL( uv, ael[5] ) );
    d = max( d, -toEL( uv, ael[6] ) );
    return d;
}

float toCurl2( vec2 uv )
{
    EL ael[4];
    ael[0] = EL( 193.0, 89.0, 100.0, 355.7, 0.919, -0.394 );
    ael[1] = EL( 198.0, 77.0, 100.0, 375.2, 0.914, -0.405 );
    ael[2] = EL( 112.0, 14.0, 385.0, 187.0, 1.000, 0.000 );
    ael[3] = EL( 321.0, 408.0, 11.0, 19.1, 0.164, 0.986 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = max( d, -toEL( uv, ael[2] ) );
    d = min( d, toEL( uv, ael[3] ) );
    return d;
}

float toCharh( vec2 uv )
{
    EL ael[4];
    ael[0] = EL( 9.0, 14.0, 81.4, 220.5, 0.821, -0.571 );
    ael[1] = EL( -7.0, -3.0, 78.9, 214.6, 0.839, -0.545 );
    ael[2] = EL( -57.0, 182.0, 100.0, 100.0, 1.000, 0.000 );
    ael[3] = EL( 104.0, -100.0, 196.0, 99.9, 0.970, 0.242 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = max( d, -toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toCharC1( uv + vec2( -110.0, 0.0 ) ) );
    d = min( d, toCurl( uv + vec2( -20.0, 0.0 ) ) );
    return d;
}

float toCharpm( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 273.0, -7.0, 100.0, 224.2, 0.875, -0.485 );
    ael[1] = EL( 264.0, -20.0, 88.4, 225.2, 0.866, -0.500 );
    ael[2] = EL( 139.0, -3.0, 100.0, 227.4, 0.875, -0.485 );
    ael[3] = EL( 131.0, -16.0, 85.9, 229.6, 0.875, -0.485 );
    ael[4] = EL( 305.0, -126.0, 417.0, 130.0, 1.000, 0.000 );
    ael[5] = EL( -21.0, -86.0, 100.0, 313.6, 0.906, -0.423 );
    ael[6] = EL( -38.0, -105.0, 88.2, 323.4, 0.899, -0.438 );
    ael[7] = EL( -99.0, 58.0, 100.0, 261.7, 0.899, -0.438 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = max( d, -toEL( uv, ael[4] ) );
    d = min( d, toEL( uv, ael[5] ) );
    d = max( d, -toEL( uv, ael[6] ) );
    d = max( d, -toEL( uv, ael[7] ) );
    d = min( d, toCharTilda( vec2( uv + vec2( -135.0, 190.0 ) ) ) );
    return d;
}

float toTilda2( vec2 uv )
{
    EL ael[4];
    ael[0] = EL( 148.0, 43.0, 224.0, 158.0, 1.000, 0.000 );
    ael[1] = EL( 156.0, 35.0, 266.0, 151.0, 1.000, 0.000 );
    ael[2] = EL( 293.0, 267.0, 100.0, 100.0, 1.000, 0.000 );
    ael[3] = EL( 290.0, 287.0, 118.0, 113.0, 1.000, 0.000 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    return d;
}

float toCharE1( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 172.0, 51.0, 132.0, 146.0, 1.000, 0.000 );
    ael[1] = EL( 189.0, 57.0, 126.7, 133.2, 1.000, 0.017 );
    ael[2] = EL( 271.0, 92.0, 146.8, 79.4, 0.755, 0.656 );
    ael[3] = EL( 261.0, 110.0, 158.9, 89.5, 0.766, 0.643 );
    ael[4] = EL( 223.0, -5.0, 59.6, 68.0, 0.999, 0.052 );
    ael[5] = EL( 209.0, -8.0, 54.0, 65.0, 1.000, 0.000 );
    ael[6] = EL( 212.0, 20.0, 62.2, 41.6, 0.982, 0.191 );
    ael[7] = EL( 210.0, 20.0, 44.1, 34.5, 0.956, 0.292 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    d = min( d, toEL( uv, ael[6] ) );
    d = max( d, -toEL( uv, ael[7] ) );
    d = min( d, toTilda2( uv ) );
    d = min( d, toCurl( uv ) );
    return d;
}

float toCharE2( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 172.0, 51.0, 132.0, 146.0, 1.000, 0.000 );
    ael[1] = EL( 189.0, 57.0, 126.7, 133.2, 1.000, 0.017 );
    ael[2] = EL( 271.0, 92.0, 146.8, 79.4, 0.755, 0.656 );
    ael[3] = EL( 261.0, 110.0, 158.9, 89.5, 0.766, 0.643 );
    ael[4] = EL( 223.0, -5.0, 59.6, 68.0, 0.999, 0.052 );
    ael[5] = EL( 209.0, -8.0, 54.0, 65.0, 1.000, 0.000 );
    ael[6] = EL( 212.0, 20.0, 62.2, 41.6, 0.982, 0.191 );
    ael[7] = EL( 210.0, 20.0, 44.1, 34.5, 0.956, 0.292 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    d = min( d, toEL( uv, ael[6] ) );
    d = max( d, -toEL( uv, ael[7] ) );
    d = min( d, toTilda2( uv ) );
    d = min( d, toCurl( uv ) );
    return d;
}

float toCharY2( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 120.0, -80.0, 74.8, 359.8, 0.875, -0.485 );
    ael[1] = EL( 117.0, -50.0, 81.7, 390.5, 0.883, -0.469 );
    ael[2] = EL( 95.0, 101.0, 66.5, 103.5, 0.940, -0.342 );
    ael[3] = EL( 109.0, 117.0, 52.8, 95.3, 0.914, -0.407 );
    ael[4] = EL( 215.0, 101.0, 66.8, 103.1, 0.940, -0.342 );
    ael[5] = EL( 224.0, 116.0, 52.6, 95.7, 0.914, -0.407 );
    ael[6] = EL( 385.0, 136.0, 100.0, 100.0, 1.000, 0.000 );
    ael[7] = EL( 388.0, 108.0, 100.0, 146.7, 0.966, -0.259 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    d = min( d, toTilda2( uv + vec2( -100.0, -15.0 ) ) );
    d = min( d, toCurl( uv + vec2( -170.0, 0.0 ) ) );
    d = min( d, toCurl2( uv + vec2( -80.0, 0.0 ) ) );
    return d;
}

float toPeriod( vec2 uv )
{
    EL ael[1];
    ael[0] = EL( 40.0, 23.0, 21.0, 22.0, 1.000, 0.000 );
    float d = toEL( uv, ael[0] );
    return d;
}

float toCharC2( vec2 uv )
{
    EL ael[6];
    ael[0] = EL( 88.0, 80.0, 81.9, 278.4, 0.914, -0.407 );
    ael[1] = EL( 89.0, 59.0, 87.8, 292.0, 0.914, -0.407 );
    ael[2] = EL( -51.0, 15.0, 40.0, 124.9, 0.945, -0.328 );
    ael[3] = EL( 98.0, 100.0, 78.4, 105.8, 0.866, -0.500 );
    ael[4] = EL( 88.0, 94.0, 70.9, 95.2, 0.866, -0.500 );
    ael[5] = EL( 46.0, 22.0, 11.6, 16.4, 0.755, 0.656 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = max( d, -toEL( uv, ael[2] ) );
    d = min( d, toEL( uv, ael[3] ) );
    d = max( d, -toEL( uv, ael[4] ) );
    d = min( d, toEL( uv, ael[5] ) );
    return d;
}

float toCharY3( vec2 uv )
{
    EL ael[6];
    ael[0] = EL( 23.0, -51.0, 77.6, 268.1, 0.934, -0.358 );
    ael[1] = EL( 6.0, -62.0, 77.5, 273.0, 0.921, -0.391 );
    ael[2] = EL( 75.0, 77.0, 60.5, 74.5, 0.993, -0.121 );
    ael[3] = EL( 78.0, 95.0, 55.8, 82.7, 0.993, -0.122 );
    ael[4] = EL( -27.0, 82.0, 44.2, 126.6, 0.951, -0.309 );
    ael[5] = EL( -37.0, 57.0, 49.4, 138.5, 0.968, -0.253 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    return d;
}

float toSmallTilda( vec2 uv )
{
    EL ael[4];
    ael[0] = EL( 168.0, 126.0, 178.0, 84.0, 1.000, 0.000 );
    ael[1] = EL( 196.0, 84.0, 302.9, 120.3, 1.000, 0.017 );
    ael[2] = EL( 177.0, 295.0, 189.0, 95.0, 1.000, 0.000 );
    ael[3] = EL( 106.0, 310.0, 337.2, 104.9, 1.000, -0.017 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    return d;
}

float toCharE3( vec2 uv )
{
    EL ael[7];
    ael[0] = EL( 170.0, 229.0, 100.0, 244.3, 0.909, -0.418 );
    ael[1] = EL( 201.0, 253.0, 102.4, 268.7, 0.887, -0.462 );
    ael[2] = EL( 66.0, -136.0, 100.0, 153.6, 0.921, -0.391 );
    ael[3] = EL( 79.0, -126.0, 87.3, 142.4, 0.921, -0.391 );
    ael[4] = EL( 118.0, -126.0, 54.0, 69.8, 0.891, -0.454 );
    ael[5] = EL( 116.0, -142.0, 47.9, 61.1, 0.866, -0.500 );
    ael[6] = EL( 75.0, -157.0, 12.8, 11.8, 0.946, -0.326 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = max( d, -toEL( uv, ael[5] ) );
    d = min( d, toEL( uv, ael[6] ) );
    return d;
}

float toCharq( vec2 uv )
{
    EL ael[8];
    ael[0] = EL( 120.0, -80.0, 74.8, 359.8, 0.875, -0.485 );
    ael[1] = EL( 117.0, -50.0, 81.7, 390.5, 0.883, -0.469 );
    ael[2] = EL( 215.0, 101.0, 66.8, 103.1, 0.940, -0.342 );
    ael[3] = EL( 224.0, 116.0, 52.6, 95.7, 0.914, -0.407 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toSmallTilda( uv + vec2( -50.0, 0.0 ) ) );
    return d;
}

float toCharm( vec2 uv )
{
    EL ael[9];
    ael[0] = EL( 273.0, -7.0, 100.0, 224.2, 0.875, -0.485 );
    ael[1] = EL( 264.0, -20.0, 88.4, 225.2, 0.866, -0.500 );
    ael[2] = EL( 139.0, -3.0, 100.0, 227.4, 0.875, -0.485 );
    ael[3] = EL( 131.0, -16.0, 85.9, 229.6, 0.875, -0.485 );
    ael[4] = EL( 305.0, -126.0, 417.0, 130.0, 1.000, 0.000 );
    ael[5] = EL( -21.0, -86.0, 100.0, 313.6, 0.906, -0.423 );
    ael[6] = EL( -38.0, -105.0, 88.2, 323.4, 0.899, -0.438 );
    ael[7] = EL( -99.0, 58.0, 100.0, 261.7, 0.899, -0.438 );
    ael[8] = EL( 95.0, -110.0, 195.0, 101.0, 1.000, 0.000 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = max( d, -toEL( uv, ael[4] ) );
    d = min( d, toEL( uv, ael[5] ) );
    d = max( d, -toEL( uv, ael[6] ) );
    d = max( d, -toEL( uv, ael[7] ) );
    d = max( d, -toEL( uv, ael[8] ) );
    d = min( d, toCharTilda( vec2( uv + vec2( -135.0, 190.0 ) ) ) );
    return d;
}

float toCharp2( vec2 uv )
{
    float d = toEL( uv, EL( 145.0, 100.0, 100.0, 100.0, 1.0, 0.0 ) );
    d = max( d, -toEL( uv, EL( 182.0, 90.0, 139.0, 112.0, 1.0, 0.0 ) ) );
    d = min( d, toEL( uv, EL( 95.0, 68.0, 49.0, 141.0, 0.92, -0.39 ) ) );
    d = max( d, -toEL( uv, EL( 71.0, 28.0, 51.5, 180.2, 0.92, -0.39 ) ) );
    d = min( d, toCharj( uv + vec2( 70.0, 0.0 ) ) );
    return d;
}

float toQuotes( vec2 uv )
{
    EL ael[11];
    ael[0] = EL( -61.0, 222.0, 153.0, 95.1, 0.643, -0.766 );
    ael[1] = EL( -34.0, 239.0, 175.2, 119.3, 0.755, -0.656 );
    ael[2] = EL( -185.0, 208.0, 128.7, 48.4, 0.500, -0.866 );
    ael[3] = EL( -175.0, 152.0, 52.9, 170.0, 0.899, 0.438 );
    ael[4] = EL( -250.0, 295.0, 13.0, 11.0, 1.000, 0.000 );
    ael[5] = EL( 4.0, 98.0, 10.0, 8.0, 1.000, 0.000 );
    ael[6] = EL( -77.0, 68.0, 87.3, 25.0, 1.000, 0.000 );
    ael[7] = EL( -82.0, 75.0, 96.0, 22.0, 0.999, -0.052 );
    ael[8] = EL( -180.0, 84.0, 44.7, 7.5, 0.777, -0.629 );
    ael[9] = EL( -216.0, 103.0, 11.0, 11.0, 1.000, 0.000 );
    ael[10] = EL( -5.0, 61.0, 12.0, 9.8, 0.914, 0.407 );
    float d = toEL( uv, ael[0] );
    d = max( d, -toEL( uv, ael[1] ) );
    d = min( d, toEL( uv, ael[2] ) );
    d = max( d, -toEL( uv, ael[3] ) );
    d = min( d, toEL( uv, ael[4] ) );
    d = min( d, toEL( uv, ael[5] ) );
    d = min( d, toEL( uv, ael[6] ) );
    d = max( d, -toEL( uv, ael[7] ) );
    d = min( d, toEL( uv, ael[8] ) );
    d = min( d, toEL( uv, ael[9] ) );
    d = min( d, toEL( uv, ael[10] ) );
    return d;
}

// -------------------------------------------------------
//  Text rendering: https://www.shadertoy.com/view/MtS3RK
// -------------------------------------------------------
float texScriptF( vec2 uv )
{
    uv.x -= uv.y * 0.15;
    float d = toQuotes( uv + vec2( -180.0, 0.0 ) );
    d = min( d, toCharC( uv + vec2( -200.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -200.0, 0.0 ) ) );
    d = min( d, toCharp( uv + vec2( -340.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -480.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -630.0, 0.0 ) ) );
    d = min( d, toCharZ( uv + vec2( -760.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -760.0, 0.0 ) ) );
    d = min( d, toCharw( uv + vec2( -960.0, 0.0 ) ) );
    d = min( d, toCharTilda( uv + vec2( -960.0, 0.0 ) ) );
    d = min( d, toCharj( uv + vec2( -1230.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -1320.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -1470.0, 0.0 ) ) );
    d = min( d, toCharh( uv + vec2( -1590.0, 0.0 ) ) );
    d = min( d, toCharpm( uv + vec2( -1820.0, 0.0 ) ) );
    d = min( d, toCharj( uv + vec2( -2190.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -2280.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -2280.0, 0.0 ) ) );
    d = min( d, toCharE1( uv + vec2( -2450.0, 0.0 ) ) );
    d = min( d, toCharY2( uv + vec2( -2670.0, 0.0 ) ) );
    d = min( d, toPeriod( uv + vec2( -3000.0, 0.0 ) ) );
    
    d = min( d, toCharC( uv + vec2( -3400.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -3400.0, 0.0 ) ) );
    d = min( d, toCharp( uv + vec2( -3540.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -3680.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -3830.0, 0.0 ) ) );
    d = min( d, toCharZ( uv + vec2( -3960.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -3960.0, 0.0 ) ) );
    d = min( d, toCharw( uv + vec2( -4160.0, 0.0 ) ) );
    d = min( d, toCharTilda( uv + vec2( -4160.0, 0.0 ) ) );
    d = min( d, toCharw( uv + vec2( -4510.0, 0.0 ) ) );
    d = min( d, toCharTilda( uv + vec2( -4510.0, 0.0 ) ) );
    d = min( d, toCharpm( uv + vec2( -4770.0, 0.0 ) ) );
    d = min( d, toCharTilda( uv + vec2( -4920.0, -70.0 ) ) );
    d = min( d, toDash1( uv + vec2( -4920.0, -50.0 ) ) );
    d = min( d, toCharj( uv + vec2( -5140.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -5230.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -5230.0, 0.0 ) ) );
    d = min( d, toCharE2( uv + vec2( -5420.0, 0.0 ) ) );
    d = min( d, toQuotes( vec2( -uv.x, uv.y ) + vec2( 5760.0, 0.0 ) ) );


    d = min( d, toCharC( uv + vec2( -6200.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -6200.0, 0.0 ) ) );
    d = min( d, toCharp( uv + vec2( -6340.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -6480.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -6630.0, 0.0 ) ) );
    d = min( d, toCharZ( uv + vec2( -6760.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -6760.0, 0.0 ) ) );
    d = min( d, toCharw( uv + vec2( -6960.0, 0.0 ) ) );
    d = min( d, toCharTilda( uv + vec2( -6960.0, 0.0 ) ) );
    d = min( d, toCharC2( uv + vec2( -7260.0, 0.0 ) ) );
    d = min( d, toCharY3( uv + vec2( -7440.0, 0.0 ) ) );
    d = min( d, toCharq( uv + vec2( -7460.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -7590.0, 0.0 ) ) );
    d = min( d, toCharj( uv + vec2( -7740.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -7830.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -7800.0, 0.0 ) ) );
    d = min( d, toCharE1( uv + vec2( -8000, 0.0 ) ) );
    d = min( d, toCharY2( uv + vec2( -8220.0, 0.0 ) ) );
    d = min( d, toPeriod( uv + vec2( -8550.0, 0.0 ) ) );
    
    d = min( d, toCharw( uv + vec2( -9000.0, 0.0 ) ) );
    d = min( d, toCharTilda( uv + vec2( -9000.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -9050.0, 0.0 ) ) );
    d = min( d, toCurl2( uv + vec2( -9180.0, 0.0 ) ) );
    d = min( d, toCharpm( uv + vec2( -9260.0, 0.0 ) ) );
    d = min( d, toCharh( uv + vec2( -9630.0, 0.0 ) ) );
    d = min( d, toCharE3( uv + vec2( -9920.0, 0.0 ) ) );
    d = min( d, toCharm( uv + vec2( -10030.0, 0.0 ) ) );
    d = min( d, toCurl( uv + vec2( -10150.0, 0.0 ) ) );
    d = min( d, toCharC( uv + vec2( -10430.0, 0.0 ) ) );
    d = min( d, toDash1( uv + vec2( -10430.0, 0.0 ) ) );
    d = min( d, toCharp( uv + vec2( -10560.0, 0.0 ) ) );
    d = min( d, toDash1( uv + vec2( -10650.0, 0.0 ) ) );
    d = min( d, toCharq( uv + vec2( -10620.0, 0.0 ) ) );
    d = min( d, toCharY3( uv + vec2( -10940.0, 0.0 ) ) );
    d = min( d, toCharp2( uv + vec2( -11130.0, 0.0 ) ) );
    d = min( d, toSmallTilda( uv + vec2( -11080.0, 200.0 ) ) );
    d = min( d, toSmallTilda( uv + vec2( -11080.0, -50.0 ) ) );
    d = min( d, toDash1( uv + vec2( -11100.0, 0.0 ) ) );
    d = min( d, toCharj( uv + vec2( -11310.0, 0.0 ) ) );
    d = min( d, toCharC1( uv + vec2( -11400.0, 0.0 ) ) );
    d = min( d, toDash3( uv + vec2( -11380.0, 0.0 ) ) );
    d = min( d, toCharE1( uv + vec2( -11600.0, 0.0 ) ) );

    if ( d <= 0.0 ) return 1.0;
    else return 0.0;
}

// --------------------
//  "noisy" gold color
// --------------------
vec3 Gold(vec3 p, float fade)
{
    p += .4 * noise(p * 24.);
    float t = noise(p * 30.);

    vec3 gold = mix(GOLD1, GOLD2, smoothstep(.55, .95, t));
    // darker gold tint if the inscription is visible
    gold = mix(gold, GOLD3, smoothstep(.45, .25, t)) * (1. - 0.666 * fade);

    return gold;
}

// ----------------------------------------
//  calculate ray direction for eye/camera
// ----------------------------------------
vec3 EyeRay(vec2 fragCoord, vec3 eyeDir)
{
      vec2 uv = fragCoord.xy / iResolution.xy; 
      uv = uv * 2.0 - 1.0;
      uv.x *= iResolution.x / iResolution.y;

    vec3 forward = normalize(eyeDir);
    vec3 right   = normalize(cross(vec3(.0, 1., .0), forward));
    vec3 up      = normalize(cross(forward, right));    

    return normalize(uv.x * right + uv.y * up + forward * FOV);
}

// ----------------------------------------------
//  SDF for the ring - a slightly deformed torus
// ----------------------------------------------
float Ring(vec3 pos)
{
    vec2 t = vec2(RING_RADIUS, RING_RADIUS * .2);
    vec2 q = vec2(clamp(2. * (length(pos.xz) - t.x), -5., 5.),pos.y);

    return length(q) - t.y;
}

// -------------------------------
//  flickering hellish background
// -------------------------------
vec3 Background(vec3 ray)
{ 
    return texture(iChannel2, ray).rgb * vec3(.7, .15, .0) * (1. + texture(iChannel1, vec2(0., 0.)).r);
}

// ----------------
//  surface normal
// ----------------
vec3 SurfaceNormal(in vec3 pos)
{
    vec3 eps = vec3( MIN_DIST, 0., 0. );
    return normalize(-vec3(Ring(pos + eps.xyy) - Ring(pos - eps.xyy),
                           Ring(pos + eps.yxy) - Ring(pos - eps.yxy),
                           Ring(pos + eps.yyx) - Ring(pos - eps.yyx)));
}

// ------------------
//  scene raymarcher
// ------------------
RMInfo Raymarch(vec3 from, vec3 to)
{
    float t = 0.;
    int objId = BACKGROUND_ID;
    vec3 pos;
    vec3 normal;
    float dist;

      for (int i = 0; i < NUM_STEPS; ++i)
    {
        pos = from + to * t;
        dist = Ring(pos);

        if (dist > MAX_DIST || abs(dist) < MIN_DIST)
            break;

        t += dist * 0.43;
        objId = RING_ID;
      }

    if (t < MAX_DIST)
    {
        normal = SurfaceNormal(pos);
    }
    else
    {
        objId = BACKGROUND_ID;
    }

    return RMInfo(pos, normal, objId);
}


// -------------------------
//  here be scene rendering
// -------------------------
vec4 Draw(vec2 fragCoord)
{   
    vec3   col = vec3(0.);
      vec3   ray = EyeRay(fragCoord, -EYE);
      RMInfo rmi = Raymarch(EYE, ray);

    if (rmi.objId == RING_ID)
    {
        vec2 uv;
        float fade = max(0., sin(iTime * .3));
        col = mix(col, Gold(rmi.pos, fade) * texture(iChannel0, reflect(ray, rmi.normal)).rgb, .99);            
        rmi = Raymarch(rmi.pos, reflect(ray, rmi.normal));

        // render the inscription!
        uv.x = atan( rmi.pos.z, rmi.pos.x ) / 3.14159;
        uv.y = 2.0 * rmi.pos.y;

        if ( uv.y > vMin && uv.y < vMax )
        {
            uv.x = ( uv.x + 1.0 ) * 0.5;
            uv.y = 1.0 - ( uv.y - vMin ) / ( vMax - vMin );
            float s = texScriptF( uv * vec2( 12500.0, -800.0 ) + vec2( 0.0, 450.0 ));

            // text is flickering depending on current audio value
            col += vec3( 0.9, 0.9, 0.5 ) * 1.5 * fade * vec3(1., .3, 0.) * (1. + 10. * texture(iChannel1, vec2(50., 0.)).r) * s;
        }
    }
    else if(rmi.objId == BACKGROUND_ID)
    {
        col += Background(ray);
    }

      return vec4(col, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    EYE.xy = rotate(EYE.xy, iTime * .03 + .015);
    EYE.yz = rotate(EYE.yz, iTime * .03 + .015);

    // Antialiasing: https://www.shadertoy.com/view/XdVSRV
#if ANTIALIASING
    vec4 vs = vec4(0.);
    for (int j = 0; j < AA_SAMPLES ;j++)
    {
        float oy = float(j) * AA_WIDTH / max(float(AA_SAMPLES - 1), 1.);
        for (int i = 0; i < AA_SAMPLES; i++)
        {
            float ox = float(i) * AA_WIDTH / max(float(AA_SAMPLES - 1), 1.);
            vs += Draw(fragCoord + vec2(ox, oy));
        }
    }

    fragColor = vs/vec4(AA_SAMPLES * AA_SAMPLES);
#else
    fragColor = Draw(fragCoord);
#endif
}