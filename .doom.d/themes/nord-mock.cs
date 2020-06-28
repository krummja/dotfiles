/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#f0f4fc", /* black   */
  [1] = "#e3eaf5", /* red     */
  [2] = "#d8dee9", /* green   */
  [3] = "#c2d0e7", /* yellow  */
  [4] = "#b8c5db", /* blue    */
  [5] = "#aebacf", /* magenta */
  [6] = "#a1acc0", /* cyan    */
  [7] = "#60728c", /* white   */

  /* 8 bright colors */
  [8]  = "#485163", /* black   */
  [9]  = "#99324b", /* red     */
  [10] = "#4f894c", /* green   */
  [11] = "#9a7500", /* yellow  */
  [12] = "#3b6ea8", /* blue    */
  [13] = "#842879", /* magenta */
  [14] = "#398eac", /* cyan    */
  [15] = "#97365b", /* white   */

  /* special colors */
  [256] = "#e5e9f0", /* background */
  [257] = "#3b4252", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;
