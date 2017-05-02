#version 410 core

in vec3 position;

out vec4 Color;


uniform mat4 rotation;
uniform mat4 scale;
uniform mat4 translation;

uniform mat4 projection;

uniform mat4 cameraTranslation;


void main(void){
    vec4 newPos =translation*rotation*scale*vec4(position,1.0f);
    Color=vec4(position,1.0f);
    newPos =projection*cameraTranslation*newPos;
    gl_Position = newPos;
}


