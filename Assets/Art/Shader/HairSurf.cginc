﻿#include "HairBxDF.cginc"

inline fixed4 LightingHair(SurfaceOutputHair s, half3 viewDir, UnityGI gi)
{
	clip(s.Alpha - 0.5f);
	fixed4 c = fixed4(0,0,0,s.Alpha);
	//Direct Light
	c.rgb = gi.light.color * HairBxDF(s, s.Normal, viewDir, gi.light.dir, 1.0f, 1.0f, 0.0f);

	//Indirect Light
	float3 L = normalize(viewDir - s.VNormal * dot(s.VNormal, viewDir));
	c.rgb += gi.indirect.diffuse * 6.28f * HairBxDF(s, s.Normal, viewDir, gi.light.dir, 1.0f, 0.0f, 0.2f);

	return c;
}

inline void LightingHair_GI(
	SurfaceOutputHair s,
	UnityGIInput data,
	inout UnityGI gi)
{
	gi = UnityGlobalIllumination(data, 1.0f, s.VNormal);
}