#version 410 core

in vec3 Normal;
in vec3 fragmentPositionInWorld;
uniform vec3 fractionColor;

in vec3 cameraPositionInWorld;
uniform vec3 lightColor;
uniform mat4 lightPosition;


out vec4 outColor;

void main(void){
    float ambientStrength = 0.2f;
    vec3 ambient = ambientStrength * lightColor;
    vec3 lightPos = vec3(vec4(lightPosition*vec4(1.0f)).xyz);

    
    vec3 direction = normalize(lightPos-fragmentPositionInWorld);
    vec3 normalizedNormal = normalize(Normal);
    
    float diff = max(dot(normalizedNormal, direction), 0.0);
    vec3 diffuse = diff * lightColor;
    
    //specular
    float specularStrength = 0.2f;
    vec3 viewDir = normalize(cameraPositionInWorld - fragmentPositionInWorld);
    vec3 reflectDir = reflect(-lightPos, normalizedNormal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 2);
    vec3 specular = specularStrength * spec * lightColor;
    //specular end
    vec3 result = (ambient+diffuse+specular) * fractionColor;

    
    outColor = vec4(result,1.0f);
}
