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
vec3 csc(highp float hl){
	vec3 zc = mix(FOG_COLOR.rgb, vec3(0.3, 0.5, 1.0), stre(length(FOG_COLOR.rgb) - rain));
	vec3 hc = mix(sqrt(FOG_COLOR.rgb), FOG_COLOR.rgb, rain);
	return mix(tl(zc), tl(hc), hl);
}
vec3 sr(highp vec3 np){
	highp float hl = max0(sqr3(1.0 - abs(np.y)));
	return csc(hl);
}
