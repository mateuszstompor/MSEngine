#version 410 core

out vec4 outColor;
uniform vec3 fractionColor;

void main(void){
    outColor = vec4(fractionColor,1.0f);
}
