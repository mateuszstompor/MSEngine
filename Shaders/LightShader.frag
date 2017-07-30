in vec3 surfaceNormal;

out vec4 outColor;

uniform vec3 color;

void main(void){
    outColor = vec4(color,1.0f);
}

