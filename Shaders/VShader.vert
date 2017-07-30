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

out vec3 surfaceNormal;


out vec3 fragmentPositionInWorld;
out vec3 cameraPositionInWorld;




void main(void){
    mat4 modelToWorld = transformation.translation * transformation.rotation * transformation.scale;
    vec4 positionInWorld = modelToWorld * vec4(position,1.0f);
    mat4 cameraTransform = camera.translation * camera.rotation;
    fragmentPositionInWorld = positionInWorld.xyz;
    
    gl_Position = camera.projection * cameraTransform * positionInWorld;
    cameraPositionInWorld = vec4(cameraTransform*vec4(1.0f)).xyz;
    
    surfaceNormal=normal;
}
