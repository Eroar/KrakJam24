shader_type spatial;

// Uniforms
uniform mat4 modelMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat3 normalMatrix;
uniform vec3 cameraPosition;

void vertex() {
    // Default vertex attributes provided by Geometry and BufferGeometry
    vec3 position = VERTEX;
    vec3 normal = NORMAL;
    vec2 uv = UV;

    vec4 worldPosition = modelMatrix * vec4(position, 1.0);
    NORMAL = normalize(normalMatrix * normal);
	
    vec3 viewDir = normalize((CAMERA_MATRIX * vec4(0.0, 0.0, 0.0, 1.0) - vec4(VERTEX, 1.0)).xyz);
    // VIEW = (viewMatrix * worldPosition).xyz;

    VERTEX = (projectionMatrix * modelViewMatrix * vec4(position, 1.0)).xyz;
}

// Input from vertex shader
varying vec3 vNormal;
varying vec3 vViewPosition;

void fragment() {
    vec3 viewDirection = normalize(-vViewPosition);
    float intensity = max(dot(viewDirection, vNormal), 0.0);

    vec4 color;
    if (intensity > 0.95) color = vec4(1.0, 0.0, 0.0, 1.0); // Brightest shade
    else if (intensity > 0.5) color = vec4(0.7, 0.0, 0.0, 1.0); // Medium shade
    else if (intensity > 0.25) color = vec4(0.4, 0.0, 0.0, 1.0); // Darker shade
    else color = vec4(0.2, 0.0, 0.0, 1.0); // Darkest shade

    ALBEDO = color.rgb;
    ALPHA = color.a;
}