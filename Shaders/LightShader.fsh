
#version 410 core
//#version 300 es

precision highp float;

in vec3 Normal;
out vec4 outColor;
uniform vec3 lightColor;

void main(void){
    //outColor = vec4(1.0f,0.0f,0.0f,1.0f);

    outColor = vec4(lightColor,1.0f);
}

