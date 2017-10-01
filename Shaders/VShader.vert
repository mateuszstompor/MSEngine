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

mat4 lookAt( vec3 eye, vec3 target, vec3 up )
{
    vec3 zaxis = normalize(eye - target);
    vec3 xaxis = normalize(cross(up, zaxis));
    vec3 yaxis = cross(zaxis, xaxis);

    mat4 orientation = mat4(
        vec4( xaxis.x, yaxis.x, zaxis.x, 0.0f),
        vec4( xaxis.y, yaxis.y, zaxis.y, 0.0f ),
        vec4( xaxis.z, yaxis.z, zaxis.z, 0.0f ),
        vec4( 0.0f, 0.0f, 0.0f, 1.0f )
    );

    mat4 translation = mat4(
        vec4(   1,      0,      0,   0 ),
        vec4(   0,      1,      0,   0 ),
        vec4(   0,      0,      1,   0 ),
        vec4(-eye.x, -eye.y, -eye.z, 1 )
    );

    return orientation * translation;
}

void main(void){
    mat4 modelToWorld = transformation.translation * transformation.rotation * transformation.scale;
    vec4 positionInWorld = modelToWorld * vec4(position,1.0f);
    fragmentPositionInWorld = positionInWorld.xyz;
    
    gl_Position = camera.projection *  camera.rotation * camera.translation * positionInWorld;
    
    cameraPositionInWorld = vec4(camera.translation * camera.rotation * vec4(1.0f)).xyz;
    if(material.hasTexture==true){
        textureCoords=textureCoordinates;
    }
    surfaceNormal=normal;
    materiall=material;
}
