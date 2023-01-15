@tool
extends Node2D

@warning_ignore(unused_private_class_variable)
@export var _test: bool = false:
	set(__):
		test()
 
@export var atlas: AtlasTexture = null

@onready var Sprite: Sprite2D = $Sprite2D

var ctex: Texture2D = preload("res://demo_textures/exterior.png")

func _ready() -> void:
	test()

func test() -> void:
	#print(_RMU.guess_type(atlas.atlas))
	print(2 % -1)

	
#	var T: TileMap = $TileMap
#	var S: TileSetAtlasSource = T.tile_set.get_source(2)
#	var size: Vector2i = S.texture_region_size
#	print(size)
#	var img_size: Vector2i = T.get_used_rect().size * size
#	var img: Image = Image.create(img_size.x, img_size.y, false, Image.FORMAT_RGBA8)
#	for cell in T.get_used_cells(0):
#		var tile: Vector2i = T.get_cell_atlas_coords(0, cell)
#		var region: Rect2i = S.get_tile_texture_region(tile, 0)
#		img.blit_rect(S.texture.get_image(), region, cell * size) 
#	img.save_png("res://testing/test.png")
		
	
#	var color: Color = _RMUC.guess_transparent_color(ctex)
#	var img: Image = ctex.get_image()
#	_RMUC.remove_color_from_image(img, color)
#	img = _RMUC.get_part_image(img, part, false)
#	var tex: ImageTexture = ImageTexture.create_from_image(img)
#	var autotile: _RMUA = _RMUA.new()
#	autotile.source_texture = tex
#	autotile.mode = _RMUA.MODE.CLASSIC
#	autotile.convert_autotile()
#	Sprite.texture = ImageTexture.create_from_image(autotile.get_image().duplicate())
