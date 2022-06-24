#define max0(x) max(0.0, x)
#define stre(x) clamp(x, 0.0, 1.0)
#define rain smoothstep(0.65, 0.2, FOG_CONTROL.x)

uniform highp float TOTAL_REAL_WORLD_TIME;

float sqr3(float x){ return x * x * x; }
float sqr4(float x){ return x * x * x * x; }
float sqr5(float x){ return x * x * x * x * x; }

float hash(highp float n){ return fract(sin(n) * 43758.5453); }
vec3 tl(vec3 c){ return pow(c, vec3(2.2)); }
vec3 cc(vec3 c){
	c = (c * 3.0) / (1.0 + c);
	c = pow(c, vec3(0.454545));
	return mix(vec3(length(c)), c, 1.1);
}