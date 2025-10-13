#pragma header
		#define PI 3.1415926535897932384626433832795
		
		uniform float _hue;
		uniform float _saturation;
		void main(void) {
			gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
			float alpha = gl_FragColor.a;
			
			// hue
			float s = sin(_hue * PI), c = cos(_hue * PI);
			vec3 weights = (vec3(2.0 * c, -sqrt(3.0) * s - c, sqrt(3.0) * s - c) + 1.0) / 3.0;
			
			gl_FragColor.rgb = vec3(
				dot(gl_FragColor.rgb, weights.xyz),
				dot(gl_FragColor.rgb, weights.zxy),
				dot(gl_FragColor.rgb, weights.yzx)
			);
			
			// saturation
			float average = (gl_FragColor.r + gl_FragColor.g + gl_FragColor.b) / 3.0;
			
			if (_saturation > 0.0) {
				gl_FragColor.rgb += (average - gl_FragColor.rgb) * (1.0 - 1.0 / (1.001 - _saturation));
			} else {
				gl_FragColor.rgb += (average - gl_FragColor.rgb) * (-_saturation);
			}

			gl_FragColor *= alpha;
		}