void main()
{
    vec4 _color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    _color.xyz = vec(1, 1, 1) - color.xyz;
            
    gl_FragColor = color;
}