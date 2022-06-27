// __multiversion__
#include "fragmentVersionCentroid.h"
#include "uniformShaderConstants.h"
#include "uniformPerFrameConstants.h"

#if __VERSION__ >= 300
	#ifndef BYPASS_PIXEL_SHADER
		#if defined(TEXEL_AA) && defined(TEXEL_AA_FEATURE)
			_centroid in highp vec2 uv0;
			_centroid in highp vec2 uv1;
		#else
			_centroid in vec2 uv0;
			_centroid in vec2 uv1;
		#endif
	#endif
#else
	#ifndef BYPASS_PIXEL_SHADER
		varying vec2 uv0;
		varying vec2 uv1;
	#endif
#endif

#ifdef FOG
	varying float fogr;
#endif

varying highp vec4 color;
#include "util.h"

LAYOUT_BINDING(0) uniform sampler2D TEXTURE_0;
LAYOUT_BINDING(1) uniform sampler2D TEXTURE_1;
LAYOUT_BINDING(2) uniform sampler2D TEXTURE_2;

#include "common.glsl"
varying highp vec3 wpos;

void main(){
#ifdef BYPASS_PIXEL_SHADER
	gl_FragColor = vec4(0, 0, 0, 0);
	return;
#else

#if USE_TEXEL_AA
	vec4 diffuse = texture2D_AA(TEXTURE_0, uv0);
#else
	vec4 diffuse = texture2D(TEXTURE_0, uv0);
#endif

#ifdef SEASONS_FAR
	diffuse.a = 1.0;
#endif

#if USE_ALPHA_TEST
	#ifdef ALPHA_TO_COVERAGE
	#define ALPHA_THRESHOLD 0.05
	#else
	#define ALPHA_THRESHOLD 0.5
	#endif
	if(diffuse.a < ALPHA_THRESHOLD) discard;
#endif

lowp vec4 inColor = color;

#if defined(BLEND)
	diffuse.a *= inColor.a;
#endif

#ifndef ALWAYS_LIT
	vec3 lm = texture2D(TEXTURE_1, vec2(0, uv1.y)).rgb;
	diffuse.rgb *= lm + (vec3(1, 0.7, 0.4) * mix(uv1.x + sqr4(uv1.x), 0.0, lm.r));
#endif

#ifndef SEASONS
	#if !USE_ALPHA_TEST && !defined(BLEND)
		diffuse.a = inColor.a;
	#endif
	diffuse.rgb *= inColor.rgb;
#else
	diffuse.rgb *= mix(vec3(1.0), texture2D(TEXTURE_2, inColor.xy).rgb * 2.0, inColor.b);
	diffuse.rgb *= inColor.aaa;
	diffuse.a = 1.0;
#endif

#if !defined(SEASONS) && !defined(ALPHA_TEST)
	if(color.a < 0.7 && color.a > 0.5) diffuse.a *= 0.6;
#endif

	diffuse.rgb = tl(diffuse.rgb);

#ifdef FOG
	diffuse.rgb = mix(diffuse.rgb, sr(normalize(wpos)), fogr);
#endif

	diffuse.rgb = cc(diffuse.rgb);
	gl_FragColor = diffuse;
#endif
}
