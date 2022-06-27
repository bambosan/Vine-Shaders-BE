// __multiversion__
#include "fragmentVersionSimple.h"
#include "uniformPerFrameConstants.h"
#include "common.glsl"
varying highp float skyh;

void main(){
	vec3 skyc = csc(stre((skyh * skyh) * 7.5));
		skyc = cc(skyc);
	gl_FragColor = vec4(skyc, 1.0);
}
