//#version 300 es
#version 410 core
precision highp float;

in vec2 textureCoordinate;
in vec3 position;
in vec3 normal;

uniform mat4 rotation;
uniform mat4 scale;
uniform mat4 translation;

uniform mat4 projection;

uniform mat4 cameraTranslation;
uniform mat4 cameraRotation;



out vec3 cameraPositionInWorld;
out vec3 Normal;
out vec3 fragmentPositionInWorld;


void main(void){
    vec4 newPos =translation*rotation*scale*vec4(position,1.0f);
    newPos =projection*cameraTranslation*cameraRotation*newPos;
    fragmentPositionInWorld=  vec4(translation*rotation*scale*vec4(position,1.0f)).xyz;
    gl_Position = newPos;
    cameraPositionInWorld = vec4(cameraTranslation*cameraRotation*vec4(1.0f)).xyz;
    Normal=normal;
}


