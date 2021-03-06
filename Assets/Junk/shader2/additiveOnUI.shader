﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/additiveOnUI" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}

	}
	SubShader {
		Tags { "Queue"="Transparent+5000" 
				"IgnoreProjector"="True"
				"RenderType"="Transparent"
				 }
		LOD 200

		Pass {
			LOD 200
			Blend One One  
			zwrite off
			ztest off

			CGPROGRAM
			#pragma vertex vert 
	        #pragma fragment frag
	        #include "UnityCG.cginc"
			struct VertIn {
	        	float4 vertex : POSITION;
	        	float4 texcoord : TEXCOORD0;
				float4 color : COLOR;
	        };
	        
	        struct v2f {
	        	fixed4 pos : SV_POSITION;
	        	fixed2 uv : TEXCOORD0;
				fixed4 color : TEXCOORD1;
	        };

	        uniform sampler2D _MainTex; 
	         
	        v2f vert(VertIn v) 
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = MultiplyUV(UNITY_MATRIX_TEXTURE0, v.texcoord);
				o.color = v.color;
				return o;
			}

			fixed4 frag(v2f i) : Color {
                fixed4 tex2 = tex2D(_MainTex, i.uv);
                fixed4 col;
                col.rgb = tex2.rgb * i.color.rgb;
                col.a = tex2.a * i.color.a;
				return col;
			}
			
			ENDCG
		}

	} 
	FallBack "Diffuse"
}
