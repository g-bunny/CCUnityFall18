Shader "Custom/ColorShader"
{
    Properties
    {
        //_Transparency("Transparency", Range(0.0,1.0)) = 1
        _Transparency("Transparency", Range(0.0, 1.0) ) = 0.5

    }
    SubShader
    {
        //Tags { "RenderType"="Opaque" }
        Tags{ "Queue" = "Transparent" "RenderType" = "Transparent"}
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha

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
            
            v2f vert (appdata v)
            {
                v2f o;
                //this bit of code passes in the vertices from above, and maps it to how Unity handles the projection of the object in space
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            float _Transparency;
            
            fixed4 frag (v2f i) : SV_Target
            {
                //fixed4 col = fixed4(0.3, 0.3, 0.6, 1);
                fixed4 col = fixed4(i.uv.x, i.uv.y, abs(sin(_Time.y)), _Transparency);
                return col;
            }
            ENDCG
        }
    }
}