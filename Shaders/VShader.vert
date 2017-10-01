in vec3 position;
in vec3 normal;
in vec2 textureCoordinates;

struct Transformation{
    mat4 rotation;
    mat4 scale;
    mat4 translation;
};
uniform Transformation transformation;

struct Material{
    vec3    specular;
    vec3    diffuse;
    vec3    ambient;
    float   alpha;
    float   shininess;
    bool    hasTexture;
};

uniform Material material;

struct Camera {
    mat4 projection;
    mat4 translation;
    mat4 rotation;
};
uniform Camera camera;

out vec3 surfaceNormal;


out vec3 fragmentPositionInWorld;
out vec3 cameraPositionInWorld;
out vec2 textureCoords;

out Material materiall;



void main(void){
    mat4 modelToWorld = transformation.translation * transformation.rotation * transformation.scale;
    vec4 positionInWorld = modelToWorld * vec4(position,1.0f);
    fragmentPositionInWorld = positionInWorld.xyz;
    gl_Position = camera.projection * camera.rotation * camera.translation  * positionInWorld;
    cameraPositionInWorld = vec4(camera.translation * camera.rotation*vec4(1.0f)).xyz;
    if(material.hasTexture==true){
        textureCoords=textureCoordinates;
    }
    surfaceNormal=normal;
    materiall=material;
}
