#version 410 core

in vec3 Normal;
out vec4 outColor;
uniform vec3 lightColor;

void main(void){
    outColor = vec4(lightColor,1.0f);
}
