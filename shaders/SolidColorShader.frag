#pragma header

uniform vec3 color;
uniform bool shaderActive; // REMINDER TO NOT BE DUMB AND NAME THE VARIABLE ACTIVE, THATS ALREADY RESERVED!!!

void main()
{
    vec4 _color = flixel_texture2D(bitmap, openfl_TextureCoordv);

    if (shaderActive)
    {
	_color = vec4(color.x * _color.a, color.y * _color.a, color.z * _color.a, _color.a); 
    }
            
    gl_FragColor = _color;
}