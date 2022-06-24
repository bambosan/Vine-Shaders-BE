// __multiversion__

#include "vertexVersionSimple.h"
#include "uniformWorldConstants.h"
#include "uniformPerFrameConstants.h"
#include "uniformShaderConstants.h"

attribute mediump vec4 POSITION;
attribute vec4 COLOR;

varying vec4 color;

const float fogNear = 0.3;

void main(){
    gl_Position = WORLDVIEWPROJ * POSITION;
    color = mix(CURRENT_COLOR, FOG_COLOR, COLOR.r);
    color.rgb = pow(color.rgb, vec3(2.2));
}