// __multiversion__
#include "fragmentVersionSimple.h"
#include "uniformPerFrameConstants.h"
#include "common.glsl"

varying vec4 color;
void main(){
	gl_FragColor = vec4(cc(color.rgb), color.a);
}
