#pragma header

const vec2 res = vec2(1280, 720);
uniform float screens;

void main()
{
    vec2 fragCoord = openfl_TextureCoordv * res;
    vec2 uv = fragCoord.xy / res.xy;
    vec4 col = texture2D(bitmap,uv);

    float u = mod(uv.x * screens, 1.0);
    float v = mod(uv.y * screens, 1.0);

    gl_FragColor = texture2D(bitmap,vec2(u,v));
}