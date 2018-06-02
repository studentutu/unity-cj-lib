﻿/******************************************************************************/
/*
  Project - Unity CJ Lib
            https://github.com/TheAllenChou/unity-cj-lib
  
  Author  - Ming-Lun "Allen" Chou
  Web     - http://AllenChou.net
  Twitter - @TheAllenChou
*/
/******************************************************************************/

#ifndef CJ_LIB_QUATERNION_UTIL
#define CJ_LIB_QUATERNION_UTIL

#include "MathUtil.cginc"

#define kUnitQuat (float4(0.0, 0.0, 0.0, 1.0))

float4 quat_conj(float4 q)
{
  return float4(-q.xyz, q.w);
}

// q must be unit quaternion
float4 quat_pow(float4 q, float p)
{
  float r = length(q.xyz);
  if (r < kEpsilon)
    return kUnitQuat;

  float t = p * atan2(q.w, r);

  return float4(sin(t) * q.xyz / r, cos(t));
}

float4 quat_axis_angle(float3 v, float a)
{
  float h = 0.5 * a;
  return float4(sin(h) * normalize(v), cos(h));
}

float4 quat_mul(float4 q1, float4 q2)
{
  return float4(q1.w * q2.xyz + q2.w * q1.xyz + cross(q1.xyz, q2.xyz), q1.w * q2.w - dot(q1.xyz, q2.xyz));
}

float3 quat_mul(float4 q, float3 v)
{
  return dot(q.xyz, v) * q.xyz + q.w * q.w * v + 2.0 * q.w * cross(q.xyz, v) - cross(cross(q.xyz, v), q.xyz);
}

// both a & b must be unit quaternions
float4 slerp(float4 a, float4 b, float t)
{
  float d = dot(a, b);
  if (d > 0.99999)
  {
    return lerp(a, b, t);
  }

  float r = acos(saturate(d));
  return (sin((1.0 - t) * r) * a + sin(t * r) * b) / sin(r);
}

float4 nlerp(float4 a, float b, float t)
{
  return normalize(lerp(a, b, t));
}

#endif
