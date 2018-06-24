// seconds until the loading sequence stars
#define TIME_TO_LOADER 15.
// duration of the initial scrolling sequence
#define SCROLL_DURATION 10.
// positioning of the main splash image
#define SPLASH_OFFSET_X 65.
#define SPLASH_OFFSET_Y 27.
// scale factor for bitmaps
#define SCALE 256.

// test if point is inside a box
float common_BoxTest(vec2 p, vec2 bottomLeft, vec2 topRight) 
{
    vec2 s = step(bottomLeft, p) - step(topRight, p);
    return s.x * s.y;
}