package h3d.shader;

class AlphaMSDF extends hxsl.Shader {
    static var SRC = {  
		
		@param var texture : Sampler2D;
		@param var blur : Float = 1;

		var calculatedUV : Vec2;
		var pixelColor : Vec4;

		function median(r : Float, g : Float, b : Float) : Float {
		    return max(min(r, g), min(max(r, g), b));
		}

		function screenPxRange( uv : Vec2 ) : Float {
			var unitRange = vec2(blur)/vec2(texture.size());
			var screenTexSize = vec2(1.0)/fwidth(uv);
			return max(0.5*dot(unitRange, screenTexSize), 1.0);
		}

		function fragment() {
				var sample = texture.get(calculatedUV);
			var sd = median(sample.r, sample.g, sample.b);
    		var screenPxDistance = screenPxRange(calculatedUV)*(sd - 0.5);
    		pixelColor.a = clamp(screenPxDistance + 0.5, 0.0, 1.0);
		}
    }
}