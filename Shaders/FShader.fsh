in vec3 Normal;
in vec3 fragmentPositionInWorld;

uniform vec3 specularColor;
uniform vec3 diffuseColor;
uniform vec3 ambientColor;
uniform float shininess;

in vec3 cameraPositionInWorld;
uniform vec3 lightColor;
uniform mat4 lightPosition;

uniform int settings;

out vec4 outColor;


void main(void){
    float specularStrength = 0.01f;
    float ambientStrength = 0.1f;
    float diffuseStrength = 0.85f;
    float shininessStrength = 0.0009f;
    
    
    
    vec3 ambient = lightColor * ambientStrength * ambientColor;
    vec3 lightPos = (lightPosition*vec4(1.0f)).xyz;

    
    vec3 direction = normalize(lightPos-fragmentPositionInWorld);
    vec3 normalizedNormal = normalize(Normal);
    
    float diff = max(dot(normalizedNormal, direction), 0.0);
    vec3 diffuse = lightColor * diffuseStrength * diff * diffuseColor;
    
    
    
    
    
    //specular
    vec3 viewDir = normalize(cameraPositionInWorld - fragmentPositionInWorld);
    vec3 reflectDir = reflect(-lightPos, normalizedNormal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), shininessStrength*shininess);
    vec3 specular = lightColor * specularStrength * spec;
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
    outColor = vec4(sum,1.0f);
    
}
