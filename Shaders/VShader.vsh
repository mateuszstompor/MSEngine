#version 410 core

in vec3 position;
in vec3 normal;

uniform mat4 rotation;
uniform mat4 scale;
uniform mat4 translation;

uniform mat4 projection;

uniform mat4 cameraTranslation;
uniform mat4 cameraRotation;
out vec3 Normal;
void main(void){
    vec4 newPos =translation*rotation*scale*vec4(position,1.0f);
    newPos =projection*cameraTranslation*cameraRotation*newPos;
    gl_Position = newPos;
    Normal=normal;
}


