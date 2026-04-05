shader_type canvas_item;

uniform sampler2D noiseTexture;
uniform float pctg: hint_range(0.0, 1.0) = 0.0f;

void fragment() {
	vec4 originalColor = texture(TEXTURE, UV);
	vec4 finalColor = originalColor;
	vec4 noiseTex = texture(noiseTexture, UV);
	
	if (pctg >= noiseTex.r){
		finalColor.a = 0.0;
	}
	COLOR = finalColor;
}
