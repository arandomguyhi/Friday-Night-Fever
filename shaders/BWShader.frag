#pragma header

    uniform float u_colorFactor;

    void main() {
        vec4 sample = texture2D(bitmap, openfl_TextureCoordv);
        float gray = 0.21 * sample.r + 0.71 * sample.g + 0.07 * sample.b;
        gl_FragColor = vec4(sample.rgb * (1.0 - u_colorFactor) + (gray * u_colorFactor), sample.a);
    }