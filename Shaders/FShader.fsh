in vec3 surfaceNormal;
in vec3 fragmentPositionInWorld;


#define OMNI_LIGHTS_AMOUNT 10

struct Material{
    vec3    specular;
    vec3    diffuse;
    vec3    ambient;
    float   shininess;
};
uniform Material material;

struct OmniLight {
    vec3 color;
    mat4 translation;
    mat4 rotation;
    mat4 scale;
};
uniform OmniLight [OMNI_LIGHTS_AMOUNT] light;

in vec3 cameraPositionInWorld;

out vec4 outColor;

uniform int omniLightsAmount;
uniform int settings;

void main(void){
    float specularStrength = 4.8f;
    float ambientStrength = 0.09f;
    float diffuseStrength = 0.80f;
    float distanceFactor = 0.1f;
    
    
    vec3 ambient = light[0].color * ambientStrength * material.ambient * material.diffuse;
    vec3 lightPos = ( light[0].translation * light[0].rotation * light[0].scale * vec4(1.0f) ).xyz;
    
    
    float distance = dot(lightPos-fragmentPositionInWorld,lightPos-fragmentPositionInWorld);
    float lightintensity = 1.0f/(1.0f+distanceFactor * pow(distance,2));
    
    
    vec3 direction = normalize(lightPos-fragmentPositionInWorld);
    vec3 normalizedNormal = normalize(surfaceNormal);
    
    float diff = max(dot(normalizedNormal, direction), 0.0);
    vec3 diffuse = lightintensity * light[0].color * diffuseStrength * diff * material.diffuse;
    
    
    
    //specular
    vec3 incidenceVector = -normalize(lightPos-fragmentPositionInWorld);
    vec3 reflectionVector = reflect(incidenceVector, surfaceNormal);
    vec3 surfaceToCamera = normalize(cameraPositionInWorld - fragmentPositionInWorld);
    float cosAngle = max(0.0, dot(surfaceToCamera, reflectionVector));
    float specularCoefficient = pow(cosAngle, material.shininess);
    
    vec3 specular = lightintensity * light[0].color * specularCoefficient * specularStrength * material.specular;
    //specular end
    
    
    vec3 sum = vec3(0.0f);
    if ((settings & AMBIENT_SETTING) > 0){
        sum+=ambient;
    }
    if ((settings & DIFFUSE_SETTING) > 0){
        sum+=diffuse;
    }
    if ((settings & SPECULAR_SETTING) > 0){
        sum+=specular;
    }
    outColor = vec4(sum,1.0f);
    
}
