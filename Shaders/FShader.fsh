
//#version 300 es
#version 410 core
precision highp float;


in vec3 Normal;
in vec3 fragmentPositionInWorld;
uniform vec3 fractionColor;

in vec3 cameraPositionInWorld;
uniform vec3 lightColor;
uniform mat4 lightPosition;

uniform int settings;

out vec4 outColor;


void main(void){
    float ambientStrength = 0.5f;
    vec3 ambient = ambientStrength * lightColor;
    vec3 lightPos = vec3(vec4(lightPosition*vec4(1.0f)).xyz);

    
    vec3 direction = normalize(lightPos-fragmentPositionInWorld);
    vec3 normalizedNormal = normalize(Normal);
    
    float diff = max(dot(normalizedNormal, direction), 0.0);
    vec3 diffuse = diff * lightColor;
    
    //specular
    float specularStrength = 0.1f;
    vec3 viewDir = normalize(cameraPositionInWorld - fragmentPositionInWorld);
    vec3 reflectDir = reflect(-lightPos, normalizedNormal);
    float spec = max(dot(viewDir, reflectDir), 0.0) * max(dot(viewDir, reflectDir), 0.0);
    vec3 specular = specularStrength * spec * lightColor;
    //specular end
    
    
    vec3 sum = vec3(0.0f);
    
    if((settings>>0 & 1)==1){
        sum+=ambient;
    }
    if((settings>>1 & 1)==1){
        sum+=specular;
    }
    if((settings>>2 & 1)==1){
        sum+=diffuse;
    }
    if(sum == vec3(0.0f)){
        sum = vec3(1.0f);
    }
    vec3 result = sum * fractionColor;

    
    outColor = vec4(result,1.0f);
    
}
