// __multiversion__
#include "vertexVersionSimple.h"
#include "uniformWorldConstants.h"

attribute mediump vec4 POSITION;
varying highp float skyh;

void main(){
    mediump vec4 pos = POSITION;
        pos.y -= length(POSITION.xyz) * 0.3;
    gl_Position = WORLDVIEWPROJ * pos;
    skyh = length(POSITION.xz);
}
