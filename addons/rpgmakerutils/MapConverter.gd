class_name _RMUConv
extends TileMap

enum TEMPLATE {
	TWOK_EXTRACT_AUTOTILES,
	TWOK_EXTRACT_LOWER,
	TWOK_EXTRACT_UPPER,
	TWOK_EXTRACT_WATER,
	TWOK_WATER_TO_ANIM,
	TWOK_WATER_TO_MODERN,
	CLASSIC_TO_AUTOTILE,
	MODERN_TO_CLASSIC,
	WALL_TO_BLOCKTILE,
}

# TODO: Fix absolute paths
const TEMPLATES: Dictionary = {
	TEMPLATE.TWOK_EXTRACT_AUTOTILES: "res://addons/rpgmakerutils/templates/TWOKExtractAutotiles.tscn",
	TEMPLATE.TWOK_EXTRACT_LOWER: "res://addons/rpgmakerutils/templates/TWOKExtractLower.tscn",
	TEMPLATE.TWOK_EXTRACT_UPPER: "res://addons/rpgmakerutils/templates/TWOKExtractUpper.tscn",
	TEMPLATE.TWOK_EXTRACT_WATER: "res://addons/rpgmakerutils/templates/TWOKExtractWater.tscn",
	TEMPLATE.TWOK_WATER_TO_ANIM: "res://addons/rpgmakerutils/templates/TWOKWaterToAnim.tscn",
	TEMPLATE.TWOK_WATER_TO_MODERN: "res://addons/rpgmakerutils/templates/TWOKWaterToModern.tscn",
	TEMPLATE.CLASSIC_TO_AUTOTILE: "res://addons/rpgmakerutils/templates/ClassicToAutotile.tscn",
	TEMPLATE.MODERN_TO_CLASSIC: "res://addons/rpgmakerutils/templates/ModernToClassic.tscn",
	TEMPLATE.WALL_TO_BLOCKTILE: "res://addons/rpgmakerutils/templates/WallToBlocktile.tscn",
}

@export var tiles: Vector2i

static func get_texture(template: TEMPLATE, source: Texture2D, mipmaps: bool, background: Color = Color.TRANSPARENT) -> ImageTexture:
	var tile_map: _RMUConv = load(TEMPLATES[template]).instantiate()
	if not tile_map:
		push_error("Cannot find template. Maybe the addon is not in the rpgmakerutils-folder?")
		return null
	var source_width: int = source.get_width()
	var source_height: int = source.get_height()
	if source_width % tile_map.tiles.x != 0:
		push_error("Texture-width (%d) not divisible by %d" % [source_width, tile_map.tiles.x])
		tile_map.free()
		return null
	if source_height % tile_map.tiles.y != 0:
		push_error("Texture-height (%d) not divisible by %d" % [source_height, tile_map.tiles.y])
		tile_map.free()
		return null
	
	var tile_size: Vector2i = Vector2i(source_width / tile_map.tiles.x, source_height / tile_map.tiles.y)
	var _tile_set: TileSet = tile_map.tile_set.duplicate(true)
	_tile_set.tile_size = tile_size
	var tile_source: TileSetAtlasSource = _tile_set.get_source(0)
	
	tile_source.texture_region_size = Vector2i.ONE
	tile_source.texture = source
	tile_source.texture_region_size = tile_size
	
	var texture_size: Vector2i = tile_map.get_used_rect().size * tile_size
	var source_image: Image = source.get_image()
	source_image.convert(Image.FORMAT_RGBA8)
	var image: Image = Image.create(texture_size.x, texture_size.y, mipmaps, Image.FORMAT_RGBA8)
	image.fill(background)
	for cell in tile_map.get_used_cells(0):
		var source_rect: Rect2i = tile_source.get_tile_texture_region(tile_map.get_cell_atlas_coords(0, cell), 0)
		image.blit_rect(source_image, source_rect, cell * tile_size)
	tile_map.free()
	return ImageTexture.create_from_image(image)

static func get_image_region_as_texture(image: Image, x: int, y: int, w: int, h: int, mipmaps: bool) -> ImageTexture:
	return ImageTexture.create_from_image(image.get_region(Rect2i(x, y, w, h)))

static func slice(texture: Texture2D, tile_size: Vector2i, tiles_per_slice: Vector2i, mipmaps: bool) -> Array[ImageTexture]:
	var texture_width: int = texture.get_width()
	var texture_height: int = texture.get_height()
	var slice_width: int = tile_size.x * tiles_per_slice.x / 2
	var slice_height: int = tile_size.y * tiles_per_slice.y / 2
	
	if not _RMU.is_dividable(texture_width, texture_height, slice_width, slice_height):
		push_error("texture-size not dividable by slice-size (%dx%d / %dx%d)" % [texture_width, texture_height, slice_width, slice_height])
		return Array()
	
	var source_image: Image = texture.get_image()
	source_image.convert(Image.FORMAT_RGBA8)
	var output: Array[ImageTexture] = Array()
	
	for y in texture_height / slice_height:
		for x in texture_width / slice_width:
			output.append(get_image_region_as_texture(
				source_image,
				x * slice_width, y * slice_height,
				slice_width, slice_height,
				mipmaps))
	return output

static func slice_classic_autotiles(texture: Texture2D, tile_size: Vector2i, mipmaps: bool) -> Array[ImageTexture]:
	return slice(texture, tile_size, _RMU.DATABASE["CUSTOM"]["TYPES"]["AUTOTILE_CLASSIC"]["SIZE"], mipmaps)


static func slice_modern_autotiles(texture: Texture2D, tile_size: Vector2i, mipmaps: bool) -> Array[ImageTexture]:
	return slice(texture, tile_size, _RMU.DATABASE["CUSTOM"]["TYPES"]["AUTOTILE_MODERN"]["SIZE"], mipmaps)


static func slice_autoblocks(texture: Texture2D, tile_size: Vector2i, mipmaps: bool) -> Dictionary:
	var output: Dictionary = {
		"AUTOTILES": Array(),
		"BLOCKTILES": Array(),
	}
	var autotile_size: Vector2i = _RMU.DATABASE["CUSTOM"]["TYPES"]["AUTOTILE_MODERN"]["SIZE"] / 2
	var autoblock_size: Vector2i = _RMU.DATABASE["CUSTOM"]["TYPES"]["AUTOWALL"]["SIZE"] / 2
	for autoblock in slice(texture, tile_size, _RMU.DATABASE["CUSTOM"]["TYPES"]["AUTOBLOCK"]["SIZE"], mipmaps):
		var image: Image = autoblock.get_image()
		output["AUTOTILES"].append(ImageTexture.create_from_image(image.get_region(Rect2i(
			Vector2i.ZERO,
			autotile_size * tile_size))))
		output["BLOCKTILES"].append(ImageTexture.create_from_image(image.get_region(Rect2i(
			0, autotile_size.y * tile_size.y,
			autoblock_size.x * tile_size.x, autoblock_size.y * tile_size.y))))
	return output


static func slice_twok(texture: Texture2D, mipmaps: bool, transparent_color: Color = Color.TRANSPARENT) -> Array[ImageTexture]:
	texture = _RMUC.remove_color_from_texture(texture, transparent_color)
	var water: ImageTexture = get_texture(TEMPLATE.TWOK_EXTRACT_WATER, texture, mipmaps)
	return [
		get_texture(TEMPLATE.TWOK_WATER_TO_MODERN, water, mipmaps),
		get_texture(TEMPLATE.TWOK_WATER_TO_ANIM, water, mipmaps),
		get_texture(TEMPLATE.TWOK_EXTRACT_AUTOTILES, texture, mipmaps),
		get_texture(TEMPLATE.TWOK_EXTRACT_LOWER, texture, mipmaps),
		get_texture(TEMPLATE.TWOK_EXTRACT_UPPER, texture, mipmaps),
	]

static func convert_modern_autotile_slices(slices: Array[ImageTexture], mipmaps: bool) -> Array[ImageTexture]:
	var output: Array[ImageTexture] = Array()
	for slice in slices:
		var modern: ImageTexture = get_texture(TEMPLATE.MODERN_TO_CLASSIC, slice, false)
		output.append(get_texture(TEMPLATE.CLASSIC_TO_AUTOTILE, modern, mipmaps))
	return output


static func convert_classic_autotile_slices(slices: Array[ImageTexture], mipmaps: bool) -> Array[ImageTexture]:
	var output: Array[ImageTexture] = Array()
	for slice in slices:
		output.append(get_texture(TEMPLATE.CLASSIC_TO_AUTOTILE, slice, mipmaps))
	return output
