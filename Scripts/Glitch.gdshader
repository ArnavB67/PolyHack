shader_type canvas_item;

uniform sampler2D ScreenTexture: hint_screen_texture,filter_nearest;
uniform float TearStrength : hint_range(0, 0.1)= 0.03;
uniform float BlockSize : hint_range(10, 100)= 45;
uniform float RgbSplit : hint_range(0, 0.1)= 0.015;

float random(vec2 uv) {
    return fract(sin(dot(uv.xy,vec2(12.9898,78.233)))*43758.5453123);
}

void fragment() {
    vec2 uv= SCREEN_UV;
    float Block=floor(uv.y*BlockSize); 
    float TimeStep=floor(TIME*20.0); 
    float GlitchOffset= (random(vec2(Block,TimeStep))-0.5)*TearStrength;
    vec2 TornUV = uv+vec2(GlitchOffset,0);
    float R= texture(ScreenTexture,TornUV+vec2(RgbSplit*random(vec2(TIME)), 0)).r;
    float G= texture(ScreenTexture,TornUV).g;
    float B=texture(ScreenTexture,TornUV- vec2(RgbSplit*random(vec2(TIME)),0)).b;

    COLOR = vec4(R,G,B,1);
}