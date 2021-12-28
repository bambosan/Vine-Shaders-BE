// __multiversion__
#include "fragmentVersionSimple.h"
#include "uniformPerFrameConstants.h"
#include "common.glsl"
varying vec4 color;

void main(){
	vec3 col = cc(color.rgb);
	gl_FragColor = vec4(col, color.a);
}
