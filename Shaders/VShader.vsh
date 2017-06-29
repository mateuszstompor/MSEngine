in vec3 position;
in vec3 normal;







struct Transformation{
    mat4 rotation;
    mat4 scale;
    mat4 translation;
};
uniform Transformation transformation;

struct Camera {
    mat4 projection;
    mat4 translation;
    mat4 rotation;
};
uniform Camera camera;






//test

//test end


out vec3 cameraPositionInWorld;
out vec3 Normal;
out vec3 fragmentPositionInWorld;


void main(void){
    
    vec4 newPos =transformation.translation*transformation.rotation*transformation.scale*vec4(position,1.0f);
    mat4 cameraTransform = camera.translation*camera.rotation;
    newPos = camera.projection*cameraTransform*newPos;
    fragmentPositionInWorld=vec4(transformation.translation*transformation.rotation*transformation.scale*vec4(position,1.0f)).xyz;
    gl_Position = newPos;
    cameraPositionInWorld = vec4(cameraTransform*vec4(1.0f)).xyz;
    Normal=normal;
}


