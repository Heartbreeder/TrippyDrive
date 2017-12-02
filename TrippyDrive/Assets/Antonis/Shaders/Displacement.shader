Shader "LD40/Displacement"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Displacement("Displacement Map", 2D) = "white" {}
		_Strength("Displacement Strength", Range(0, 0.3)) = 0
	}
		SubShader
		{
			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				sampler2D _Displacement;
				float _Strength;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;

					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					half2 n = tex2D(_Displacement, i.uv);
					half2 d = n * 2 -1;
					i.uv += d * _Strength;
					i.uv = saturate(i.uv);
					
					float4 c = tex2D(_MainTex, i.uv);
					return c;
				}
				ENDCG
			}
		}
}