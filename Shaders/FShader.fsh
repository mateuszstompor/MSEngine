#version 410 core

out vec4 outColor;
uniform vec3 fractionColor;
uniform vec3 lightColor;

void main(void){
    float ambientStrength = 0.1f;
    vec3 ambient = ambientStrength * lightColor;
    vec3 result = ambient * fractionColor;
    outColor = vec4(result,1.0f);
}
