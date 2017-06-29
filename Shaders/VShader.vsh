in vec3 position;
in vec3 normal;

uniform mat4 rotation;
uniform mat4 scale;
uniform mat4 translation;

uniform mat4 projection;

uniform mat4 cameraRotation;

//uniform mat4 cameraTranslation;



//test
struct cam {
    mat4 camTr;
};
uniform cam cameraTranslation;
//test end


out vec3 cameraPositionInWorld;
out vec3 Normal;
out vec3 fragmentPositionInWorld;


void main(void){
    vec4 newPos =translation*rotation*scale*vec4(position,1.0f);
    newPos =projection*cameraTranslation.camTr*cameraRotation*newPos;
    fragmentPositionInWorld=vec4(translation*rotation*scale*vec4(position,1.0f)).xyz;
    gl_Position = newPos;
    cameraPositionInWorld = vec4(cameraTranslation.camTr*cameraRotation*vec4(1.0f)).xyz;
    Normal=normal;
}


