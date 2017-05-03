#version 410 core

in vec3 Normal;
out vec4 outColor;
uniform vec3 fractionColor;
uniform vec3 lightColor;

void main(void){
    float ambientStrength = 0.1f;
    vec3 ambient = ambientStrength * lightColor;
    vec3 result = ambient * fractionColor;
    outColor = vec4(Normal,1.0f);
}
