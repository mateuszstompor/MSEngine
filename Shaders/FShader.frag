
in vec3 surfaceNormal;
in vec3 fragmentPositionInWorld;
in vec3 cameraPositionInWorld;

out vec4 outColor;

struct Material{
    vec3    specular;
    vec3    diffuse;
    vec3    ambient;
    float   alpha;
    float   shininess;
};
uniform Material material;

struct OmniLight {
    vec3 color;
    float power;
    mat4 translation;
    mat4 rotation;
    mat4 scale;
};
uniform OmniLight [OMNI_LIGHTS_AMOUNT] light;



uniform int omniLightsAmount;
uniform int settings;




vec3 omniLightAmbient(Material m, OmniLight l);

vec3 omniLightDiffuse(Material m, OmniLight l,
                      float distanceBasedIntensity,
                      vec3 fragmentToLightVector, // it means lightPos-fragmentPos
                      vec3 normalToVertex);

vec3 omniLightSpecular(Material m, OmniLight l,
                       float distanceBasedIntensity,
                       vec3 fragmentToLightVector, //see description above
                       vec3 normalToVertex,
                       vec3 fragmentToCameraVector); //it means cameraPos-fragmentPos

vec3 countColor(Material m, OmniLight l, vec3 fPosInWC, vec3 cPosInWC, vec3 normalVector);
//fPosInWC fragment position in world coordinates
//cPosInWC camera ------------||------------------

void main(void){
    
    
    vec3 tempColor = vec3(0.0f);
    for(int i=0; i<omniLightsAmount; ++i){
        tempColor += countColor(material, light[i], fragmentPositionInWorld, cameraPositionInWorld, surfaceNormal);
    }
    outColor = vec4(tempColor, material.alpha);
    
}

vec3 omniLightAmbient(Material m, OmniLight l){
    return l.color * AMBIENT_STRENGTH * m.ambient * m.diffuse;
}
vec3 omniLightDiffuse(Material m, OmniLight l,
                      float distanceBasedIntensity,
                      vec3 fragmentToLightVector,
                      vec3 normalToVertex){
    
        vec3 direction = normalize(fragmentToLightVector);
        float diff = max(dot(normalToVertex, direction), 0.0);
        return distanceBasedIntensity * l.color * DIFFUSE_STRENGTH * diff * m.diffuse;
}

vec3 omniLightSpecular(Material m, OmniLight l,
                       float distanceBasedIntensity,
                       vec3 fragmentToLightVector,
                       vec3 normalToVertex,
                       vec3 fragmentToCameraVector){
    
        vec3 incidenceVector = -normalize(fragmentToLightVector);
        vec3 reflectionVector = reflect(incidenceVector, normalToVertex);
        vec3 surfaceToCamera = normalize(fragmentToCameraVector);
        float cosAngle = max(0.0, dot(surfaceToCamera, reflectionVector));
        float specularCoefficient = pow(cosAngle, m.shininess);
        return distanceBasedIntensity * l.color * specularCoefficient * SPECULAR_STRENGTH * m.specular;
}
vec3 countColor(Material m, OmniLight l, vec3 fPosInWC, vec3 cPosInWC, vec3 normalVector){
    
    vec3 ambient = omniLightAmbient(material, l);
    vec3 lightPos = ( l.translation * l.rotation * l.scale * vec4(1.0f) ).xyz;
    
    
    float distance = dot(lightPos-fPosInWC,lightPos-fPosInWC);
    float distanceFactor = 1.0f / l.power;
    float lightintensity = 1.0f / (1.0f + distanceFactor * pow(distance, 2.0));
    
    vec3 fragmentToLightVec = lightPos - fPosInWC;
    
    vec3 diffuse = omniLightDiffuse(m, l, lightintensity, fragmentToLightVec, normalVector);
    vec3 specular = omniLightSpecular(m, l, lightintensity, fragmentToLightVec, normalVector, cPosInWC - fPosInWC);
    return ambient+diffuse+specular;
}


