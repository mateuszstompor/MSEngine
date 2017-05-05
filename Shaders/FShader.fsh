#version 410 core

in vec3 Normal;
out vec4 outColor;
uniform vec3 fractionColor;
uniform vec3 lightColor;

void main(void){
    float ambientStrength = 0.1f;
    vec3 ambient = ambientStrength * lightColor;
    vec3 result = ambient * fractionColor;
    //vec3 norm = vec3(sqrt(Normal.x*Normal.x),sqrt(Normal.y*Normal.y),sqrt(Normal.z*Normal.z));
    outColor = vec4(Normal,1.0f);
}
