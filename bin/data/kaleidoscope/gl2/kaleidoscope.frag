#version 120

const float PI = 3.141592658;
const float TAU = 2.0 * PI;
const float sections = 10.0;

const float TAUsect = TAU/sections;
const float PIsect = PI/sections;

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;

uniform sampler2D tex0;
varying vec2 texCoordVarying;

void main(void){
   vec2 pos = texCoordVarying*resolution-resolution*0.5; //screen space
   
   float rad = length(pos);
   float angle = atan(pos.y, pos.x);
   
   float ma = mod(angle, TAUsect);
   ma = abs(ma - PIsect);
   
   float x = cos(ma) * rad + mouse.x;
   float y = sin(ma) * rad + mouse.y;
	
   float t = time*5.;
   
   gl_FragColor = texture2D(tex0, vec2(x-t,y-t)/resolution.y); //back to texture space
   
}