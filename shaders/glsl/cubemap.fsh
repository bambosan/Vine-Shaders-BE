// __multiversion__
#include "fragmentVersionSimple.h"
#include "uniformPerFrameConstants.h"
#include "common.glsl"

varying highp vec3 pos;

void main(){
	highp vec3 ajp = normalize(vec3(pos.x, -pos.y + 0.128, -pos.z));
	vec4 color = vec4(sr(ajp), sqr4(1.0 - max0(ajp.y)));
		color.rgb = cc(color.rgb);
	gl_FragColor = color;
}
