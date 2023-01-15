class_name _RMUC



## Top-left pixel of the first upper layer tile
const GUESS_PIXEL: Vector2i = Vector2i(288, 128)


## Returns the color of a pixel that is usually in a completly transparent tile
static func guess_transparent_color(texture: Texture2D) -> Color:
	return texture.get_image().get_pixelv(GUESS_PIXEL)


## Returns if two Colors are equal. Ignores the alpha-channel
static func is_opaque_color_equal_approx(color_1: Color, color_2: Color) -> bool:
	color_1.a = 0.0
	color_2.a = 0.0
	return color_1.is_equal_approx(color_2)


## Sets the alpha-channel of each pixel with the targeted color to transparent
static func remove_color_from_texture(texture: Texture2D, color: Color = Color.TRANSPARENT) -> ImageTexture:
	if color == Color.TRANSPARENT:
		color = guess_transparent_color(texture)
	var image: Image = texture.get_image()
	image.convert(Image.FORMAT_RGBA8)
	for x in image.get_width():
		for y in image.get_height():
			var pixel: Color = image.get_pixel(x, y)
			if is_opaque_color_equal_approx(pixel, color):
				pixel.a = 0.0
				image.set_pixel(x, y, pixel)
	return ImageTexture.create_from_image(image)
