# REFACTOR ME!!!
@tool
class_name _RMUA
extends ImageTexture


enum MODE {
	MODERN = 0,
	CLASSIC = 1,
	CLASSIC_WATER_LEFT = 2, # some space
	CLASSIC_WATER_RIGHT = 5, # for the 3
	CLASSIC_WATER_DEEP = 8, # animation frames
}


enum {
	CELLS_HORIZONTAL,
	CELLS_VERTICAL,
	MIN_WIDTH,
	MIN_HEIGHT,
	SUBTILES,
}


enum {
	CENTER_TOP_LEFT,
	CENTER_TOP_RIGHT,
	CENTER_BOTTOM_LEFT,
	CENTER_BOTTOM_RIGHT,
	
	INNER_TOP_LEFT,
	INNER_TOP_RIGHT,
	INNER_BOTTOM_LEFT,
	INNER_BOTTOM_RIGHT,
	
	OUTER_TOP_LEFT_TOP_LEFT,
	OUTER_TOP_LEFT_TOP_RIGHT,
	OUTER_TOP_LEFT_BOTTOM_LEFT,
	OUTER_TOP_LEFT_BOTTOM_RIGHT,
	
	OUTER_TOP_RIGHT_TOP_LEFT,
	OUTER_TOP_RIGHT_TOP_RIGHT,
	OUTER_TOP_RIGHT_BOTTOM_LEFT,
	OUTER_TOP_RIGHT_BOTTOM_RIGHT,
	
	OUTER_BOTTOM_LEFT_TOP_LEFT,
	OUTER_BOTTOM_LEFT_TOP_RIGHT,
	OUTER_BOTTOM_LEFT_BOTTOM_LEFT,
	OUTER_BOTTOM_LEFT_BOTTOM_RIGHT,
	
	OUTER_BOTTOM_RIGHT_TOP_LEFT,
	OUTER_BOTTOM_RIGHT_TOP_RIGHT,
	OUTER_BOTTOM_RIGHT_BOTTOM_LEFT,
	OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT,

	EDGE_LEFT_TOP_LEFT,
	EDGE_LEFT_TOP_RIGHT,
	EDGE_LEFT_BOTTOM_LEFT,
	EDGE_LEFT_BOTTOM_RIGHT,
	
	EDGE_RIGHT_TOP_LEFT,
	EDGE_RIGHT_TOP_RIGHT,
	EDGE_RIGHT_BOTTOM_LEFT,
	EDGE_RIGHT_BOTTOM_RIGHT,
	
	EDGE_TOP_TOP_LEFT,
	EDGE_TOP_TOP_RIGHT,
	EDGE_TOP_BOTTOM_LEFT,
	EDGE_TOP_BOTTOM_RIGHT,
	
	EDGE_BOTTOM_TOP_LEFT,
	EDGE_BOTTOM_TOP_RIGHT,
	EDGE_BOTTOM_BOTTOM_LEFT,
	EDGE_BOTTOM_BOTTOM_RIGHT,
}

## Define the subtiles for each mode
func _create_autotile_dict(cells_horizontal: int, cells_vertical: int,
		ctl: Vector2i, ctr: Vector2i, cbl: Vector2i, cbr: Vector2i,
		itl: Vector2i, itr: Vector2i, ibl: Vector2i, ibr: Vector2i,
		otl_tl: Vector2i, otl_tr: Vector2i, otl_bl: Vector2i, otl_br: Vector2i,
		otr_tl: Vector2i, otr_tr: Vector2i, otr_bl: Vector2i, otr_br: Vector2i,
		obl_tl: Vector2i, obl_tr: Vector2i, obl_bl: Vector2i, obl_br: Vector2i,
		obr_tl: Vector2i, obr_tr: Vector2i, obr_bl: Vector2i, obr_br: Vector2i,
		el_tl: Vector2i, el_tr: Vector2i, el_bl: Vector2i, el_br: Vector2i,
		er_tl: Vector2i, er_tr: Vector2i, er_bl: Vector2i, er_br: Vector2i,
		et_tl: Vector2i, et_tr: Vector2i, et_bl: Vector2i, et_br: Vector2i,
		eb_tl: Vector2i, eb_tr: Vector2i, eb_bl: Vector2i, eb_br: Vector2i,) -> Dictionary:
	return {
		CELLS_HORIZONTAL: cells_horizontal,
		CELLS_VERTICAL: cells_vertical,
		MIN_WIDTH: cells_horizontal * 2,
		MIN_HEIGHT: cells_vertical * 2,
		SUBTILES: {
			CENTER_TOP_LEFT: ctl,
			CENTER_TOP_RIGHT: ctr,
			CENTER_BOTTOM_LEFT: cbl,
			CENTER_BOTTOM_RIGHT: cbr,
			
			INNER_TOP_LEFT: itl,
			INNER_TOP_RIGHT: itr,
			INNER_BOTTOM_LEFT: ibl,
			INNER_BOTTOM_RIGHT: ibr,
			
			OUTER_TOP_LEFT_TOP_LEFT: otl_tl,
			OUTER_TOP_LEFT_TOP_RIGHT: otl_tr,
			OUTER_TOP_LEFT_BOTTOM_LEFT: otl_bl,
			OUTER_TOP_LEFT_BOTTOM_RIGHT: otl_br,
			
			OUTER_TOP_RIGHT_TOP_LEFT: otr_tl,
			OUTER_TOP_RIGHT_TOP_RIGHT: otr_tr,
			OUTER_TOP_RIGHT_BOTTOM_LEFT: otr_bl,
			OUTER_TOP_RIGHT_BOTTOM_RIGHT: otr_br,
			
			OUTER_BOTTOM_LEFT_TOP_LEFT: obl_tl,
			OUTER_BOTTOM_LEFT_TOP_RIGHT: obl_tr,
			OUTER_BOTTOM_LEFT_BOTTOM_LEFT: obl_bl,
			OUTER_BOTTOM_LEFT_BOTTOM_RIGHT: obl_br,
			
			OUTER_BOTTOM_RIGHT_TOP_LEFT: obr_tl,
			OUTER_BOTTOM_RIGHT_TOP_RIGHT: obr_tr,
			OUTER_BOTTOM_RIGHT_BOTTOM_LEFT: obr_bl,
			OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT:obr_br,

			EDGE_LEFT_TOP_LEFT: el_tl,
			EDGE_LEFT_TOP_RIGHT: el_tr,
			EDGE_LEFT_BOTTOM_LEFT: el_bl,
			EDGE_LEFT_BOTTOM_RIGHT: el_br,
			
			EDGE_RIGHT_TOP_LEFT: er_tl,
			EDGE_RIGHT_TOP_RIGHT: er_tr,
			EDGE_RIGHT_BOTTOM_LEFT: er_bl,
			EDGE_RIGHT_BOTTOM_RIGHT: er_br,
			
			EDGE_TOP_TOP_LEFT: et_tl,
			EDGE_TOP_TOP_RIGHT: et_tr,
			EDGE_TOP_BOTTOM_LEFT: et_bl,
			EDGE_TOP_BOTTOM_RIGHT: et_br,
			
			EDGE_BOTTOM_TOP_LEFT: eb_tl,
			EDGE_BOTTOM_TOP_RIGHT: eb_tr,
			EDGE_BOTTOM_BOTTOM_LEFT: eb_bl,
			EDGE_BOTTOM_BOTTOM_RIGHT: eb_br,
		},
	}


var AUTOTILE: Dictionary = {
	MODE.MODERN: _create_autotile_dict(2, 3,
		Vector2i(2, 4), Vector2i(1, 4), Vector2i(2, 3), Vector2i(1, 3), # Center
		Vector2i(2, 0), Vector2i(3, 0), Vector2i(2, 1), Vector2i(3, 1), # Inner
		Vector2i(0, 2), Vector2i(1, 2), Vector2i(0, 3), Vector2i(1, 3), # Outer Top Left
		Vector2i(2, 2), Vector2i(3, 2), Vector2i(2, 3), Vector2i(3, 3), # Outer Top Right
		Vector2i(0, 4), Vector2i(1, 4), Vector2i(0, 5), Vector2i(1, 5), # Outer Bottom Left
		Vector2i(2, 4), Vector2i(3, 4), Vector2i(2, 5), Vector2i(3, 5), # Outer Bottom Right
		Vector2i(0, 4), Vector2i(1, 4), Vector2i(0, 3), Vector2i(1, 3), # Edge Left
		Vector2i(2, 4), Vector2i(3, 4), Vector2i(2, 3), Vector2i(3, 3), # Edge Right
		Vector2i(2, 2), Vector2i(1, 2), Vector2i(2, 3), Vector2i(1, 3), # Edge Top
		Vector2i(2, 4), Vector2i(1, 4), Vector2i(2, 5), Vector2i(1, 5)), # Edge Bottom
	
	MODE.CLASSIC: _create_autotile_dict(3, 4,
		Vector2i(2, 4), Vector2i(3, 4), Vector2i(2, 5), Vector2i(3, 5), # Center
		Vector2i(4, 0), Vector2i(5, 0), Vector2i(4, 1), Vector2i(5, 1), # Inner
		Vector2i(0, 2), Vector2i(1, 2), Vector2i(0, 3), Vector2i(1, 3), # Outer Top Left
		Vector2i(4, 2), Vector2i(5, 2), Vector2i(4, 3), Vector2i(5, 3), # Outer Top Right
		Vector2i(0, 6), Vector2i(1, 6), Vector2i(0, 7), Vector2i(1, 7), # Outer Bottom Left
		Vector2i(4, 6), Vector2i(5, 6), Vector2i(4, 7), Vector2i(5, 7), # Outer Bottom Right
		Vector2i(0, 4), Vector2i(1, 4), Vector2i(0, 5), Vector2i(1, 5), # Edge Left
		Vector2i(4, 4), Vector2i(5, 4), Vector2i(4, 5), Vector2i(5, 5), # Edge Right
		Vector2i(2, 2), Vector2i(3, 2), Vector2i(2, 3), Vector2i(3, 3), # Edge Top
		Vector2i(2, 6), Vector2i(3, 6), Vector2i(2, 7), Vector2i(3, 7)), # Edge Bottom
	
	MODE.CLASSIC_WATER_LEFT + 0: _create_autotile_dict(3, 4,
		Vector2i(0, 8), Vector2i(1, 8), Vector2i(0, 9), Vector2i(1, 9), # Center
		Vector2i(0, 6), Vector2i(1, 6), Vector2i(0, 7), Vector2i(1, 7), # Inner
		Vector2i(0, 0), Vector2i(1, 4), Vector2i(0, 3), Vector2i(1, 9), # Outer Top Left
		Vector2i(0, 4), Vector2i(1, 0), Vector2i(0, 9), Vector2i(1, 3), # Outer Top Right
		Vector2i(0, 2), Vector2i(1, 8), Vector2i(0, 1), Vector2i(1, 5), # Outer Bottom Left
		Vector2i(0, 8), Vector2i(1, 2), Vector2i(0, 5), Vector2i(1, 1), # Outer Bottom Right
		Vector2i(0, 2), Vector2i(1, 8), Vector2i(0, 3), Vector2i(1, 9), # Edge Left
		Vector2i(0, 8), Vector2i(1, 2), Vector2i(0, 9), Vector2i(1, 3), # Edge Right
		Vector2i(0, 4), Vector2i(1, 4), Vector2i(0, 9), Vector2i(1, 9), # Edge Top
		Vector2i(0, 8), Vector2i(1, 8), Vector2i(0, 5), Vector2i(1, 5)), # Edge Bottom

	MODE.CLASSIC_WATER_LEFT + 1: _create_autotile_dict(3, 4,
		Vector2i(2, 8), Vector2i(3, 8), Vector2i(2, 9), Vector2i(3, 9), # Center
		Vector2i(2, 6), Vector2i(3, 6), Vector2i(2, 7), Vector2i(3, 7), # Inner
		Vector2i(2, 0), Vector2i(3, 4), Vector2i(2, 3), Vector2i(3, 9), # Outer Top Left
		Vector2i(2, 4), Vector2i(3, 0), Vector2i(2, 9), Vector2i(3, 3), # Outer Top Right
		Vector2i(2, 2), Vector2i(3, 8), Vector2i(2, 1), Vector2i(3, 5), # Outer Bottom Left
		Vector2i(2, 8), Vector2i(3, 2), Vector2i(2, 5), Vector2i(3, 1), # Outer Bottom Right
		Vector2i(2, 2), Vector2i(3, 8), Vector2i(2, 3), Vector2i(3, 9), # Edge Left
		Vector2i(2, 8), Vector2i(3, 2), Vector2i(2, 9), Vector2i(3, 3), # Edge Right
		Vector2i(2, 4), Vector2i(3, 4), Vector2i(2, 9), Vector2i(3, 9), # Edge Top
		Vector2i(2, 8), Vector2i(3, 8), Vector2i(2, 5), Vector2i(3, 5)), # Edge Bottom

	MODE.CLASSIC_WATER_LEFT + 2: _create_autotile_dict(3, 4,
		Vector2i(4, 8), Vector2i(5, 8), Vector2i(4, 9), Vector2i(5, 9), # Center
		Vector2i(4, 6), Vector2i(5, 6), Vector2i(4, 7), Vector2i(5, 7), # Inner
		Vector2i(4, 0), Vector2i(5, 4), Vector2i(4, 3), Vector2i(5, 9), # Outer Top Left
		Vector2i(4, 4), Vector2i(5, 0), Vector2i(4, 9), Vector2i(5, 3), # Outer Top Right
		Vector2i(4, 2), Vector2i(5, 8), Vector2i(4, 1), Vector2i(5, 5), # Outer Bottom Left
		Vector2i(4, 8), Vector2i(5, 2), Vector2i(4, 5), Vector2i(5, 1), # Outer Bottom Right
		Vector2i(4, 2), Vector2i(5, 8), Vector2i(4, 3), Vector2i(5, 9), # Edge Left
		Vector2i(4, 8), Vector2i(5, 2), Vector2i(4, 9), Vector2i(5, 3), # Edge Right
		Vector2i(4, 4), Vector2i(5, 4), Vector2i(4, 9), Vector2i(5, 9), # Edge Top
		Vector2i(4, 8), Vector2i(5, 8), Vector2i(4, 5), Vector2i(5, 5)), # Edge Bottom

	MODE.CLASSIC_WATER_RIGHT + 0: _create_autotile_dict(3, 4,
		Vector2i(0, 8), Vector2i(1, 8), Vector2i(0, 9), Vector2i(1, 9), # Center
		Vector2i(6, 6), Vector2i(7, 6), Vector2i(6, 7), Vector2i(7, 7), # Inner
		Vector2i(6, 0), Vector2i(7, 4), Vector2i(6, 3), Vector2i(1, 9), # Outer Top Left
		Vector2i(6, 4), Vector2i(7, 0), Vector2i(0, 9), Vector2i(7, 3), # Outer Top Right
		Vector2i(6, 2), Vector2i(1, 8), Vector2i(6, 1), Vector2i(7, 5), # Outer Bottom Left
		Vector2i(0, 8), Vector2i(7, 2), Vector2i(6, 5), Vector2i(7, 1), # Outer Bottom Right
		Vector2i(6, 2), Vector2i(1, 8), Vector2i(6, 3), Vector2i(1, 9), # Edge Left
		Vector2i(0, 8), Vector2i(7, 2), Vector2i(0, 9), Vector2i(7, 3), # Edge Right
		Vector2i(6, 4), Vector2i(7, 4), Vector2i(0, 9), Vector2i(1, 9), # Edge Top
		Vector2i(0, 8), Vector2i(1, 8), Vector2i(6, 5), Vector2i(7, 5)), # Edge Bottom

	MODE.CLASSIC_WATER_RIGHT + 1: _create_autotile_dict(3, 4,
		Vector2i(2, 8), Vector2i(3, 8), Vector2i(2, 9), Vector2i(3, 9), # Center
		Vector2i(8, 6), Vector2i(9, 6), Vector2i(8, 7), Vector2i(9, 7), # Inner
		Vector2i(8, 0), Vector2i(9, 4), Vector2i(8, 3), Vector2i(3, 9), # Outer Top Left
		Vector2i(8, 4), Vector2i(9, 0), Vector2i(2, 9), Vector2i(9, 3), # Outer Top Right
		Vector2i(8, 2), Vector2i(3, 8), Vector2i(8, 1), Vector2i(9, 5), # Outer Bottom Left
		Vector2i(2, 8), Vector2i(9, 2), Vector2i(8, 5), Vector2i(9, 1), # Outer Bottom Right
		Vector2i(8, 2), Vector2i(3, 8), Vector2i(8, 3), Vector2i(3, 9), # Edge Left
		Vector2i(2, 8), Vector2i(9, 2), Vector2i(2, 9), Vector2i(9, 3), # Edge Right
		Vector2i(8, 4), Vector2i(9, 4), Vector2i(2, 9), Vector2i(3, 9), # Edge Top
		Vector2i(2, 8), Vector2i(3, 8), Vector2i(8, 5), Vector2i(9, 5)), # Edge Bottom

	MODE.CLASSIC_WATER_RIGHT + 2: _create_autotile_dict(3, 4,
		Vector2i(4, 8), Vector2i(5, 8), Vector2i(4, 9), Vector2i(5, 9), # Center
		Vector2i(10, 6), Vector2i(11, 6), Vector2i(10, 7), Vector2i(11, 7), # Inner
		Vector2i(10, 0), Vector2i(11, 4), Vector2i(10, 3), Vector2i(5, 9), # Outer Top Left
		Vector2i(10, 4), Vector2i(11, 0), Vector2i(4, 9), Vector2i(11, 3), # Outer Top Right
		Vector2i(10, 2), Vector2i(5, 8), Vector2i(10, 1), Vector2i(11, 5), # Outer Bottom Left
		Vector2i(4, 8), Vector2i(11, 2), Vector2i(10, 5), Vector2i(11, 1), # Outer Bottom Right
		Vector2i(10, 2), Vector2i(5, 8), Vector2i(10, 3), Vector2i(5, 9), # Edge Left
		Vector2i(4, 8), Vector2i(11, 2), Vector2i(4, 9), Vector2i(11, 3), # Edge Right
		Vector2i(10, 4), Vector2i(11, 4), Vector2i(4, 9), Vector2i(5, 9), # Edge Top
		Vector2i(4, 8), Vector2i(5, 8), Vector2i(10, 5), Vector2i(11, 5)), # Edge Bottom

	MODE.CLASSIC_WATER_DEEP + 0: _create_autotile_dict(3, 4,
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15), # Center
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15), # Inner
		Vector2i(0, 12), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15), # Outer Top Left
		Vector2i(0, 14), Vector2i(1, 12), Vector2i(0, 15), Vector2i(1, 15), # Outer Top Right
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 13), Vector2i(1, 15), # Outer Bottom Left
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 13), # Outer Bottom Right
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15), # Edge Left
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15), # Edge Right
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15), # Edge Top
		Vector2i(0, 14), Vector2i(1, 14), Vector2i(0, 15), Vector2i(1, 15)), # Edge Bottom

	MODE.CLASSIC_WATER_DEEP + 1: _create_autotile_dict(3, 4,
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15), # Center
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15), # Inner
		Vector2i(2, 12), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15), # Outer Top Left
		Vector2i(2, 14), Vector2i(3, 12), Vector2i(2, 15), Vector2i(3, 15), # Outer Top Right
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 13), Vector2i(3, 15), # Outer Bottom Left
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 13), # Outer Bottom Right
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15), # Edge Left
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15), # Edge Right
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15), # Edge Top
		Vector2i(2, 14), Vector2i(3, 14), Vector2i(2, 15), Vector2i(3, 15)), # Edge Bottom

	MODE.CLASSIC_WATER_DEEP + 2: _create_autotile_dict(3, 4,
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15), # Center
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15), # Inner
		Vector2i(4, 12), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15), # Outer Top Left
		Vector2i(4, 14), Vector2i(5, 12), Vector2i(4, 15), Vector2i(5, 15), # Outer Top Right
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 13), Vector2i(5, 15), # Outer Bottom Left
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 13), # Outer Bottom Right
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15), # Edge Left
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15), # Edge Right
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15), # Edge Top
		Vector2i(4, 14), Vector2i(5, 14), Vector2i(4, 15), Vector2i(5, 15)), # Edge Bottom
}

## Recalculate and update texture
@warning_ignore(unused_private_class_variable)
@export var _update: bool = false:
	set(__):
		call_deferred("convert_autotile")

## Classic = 3x4 Autotiles (2000, 2003, XP)[br]Modern = 2x3 Autotiles (VX, MV, MZ, etc)[br]Deep water is broken
@export var mode: MODE = MODE.CLASSIC:
	set(new_mode):
		mode = new_mode
		frame = frame
## Only used for classic water
@export_range(0, 2) var frame: int = 0:
	set(new_frame):
		if mode > MODE.CLASSIC:
			frame = new_frame
			return
		frame = 0
## Use Mipmaps
@export var mipmaps: bool = false
## Make the texture a square[br](Thrid block goes to the bottom)
@export var square: bool = false
## Expand the texture to a power of 2
@export var power_of_2: bool = false
## Autotile to pick the tiles from[br]Use an AtlasTexture to crop from a bigger chipset
@export var source_texture: Texture2D

var subtile_width: int = 0
var subtile_height: int = 0

## Calculate and set the final texture
func convert_autotile() -> void:
	if not is_source_texture_valid():
		set_failure_texture()
		return
	
	var source_image: Image = source_texture.get_image()
	update_subtile_resolution(source_image)
	var subtiles: Dictionary = create_subtiles(source_image)
	var new_image: Image = create_autotile_image()
	
	blit_first_part(new_image, subtiles)
	blit_second_part(new_image, subtiles)
	blit_third_part(new_image, subtiles)
	set_image(new_image)


## Blit a tile from 4 subtiles
func blit_tile(target: Image, subtiles: Dictionary, x: int, y: int,
		top_left: int, top_right: int,
		bottom_left: int, bottom_right: int) -> void:
	x *= subtile_width * 2
	y *= subtile_height * 2
	var rect: Rect2i = Rect2i(0, 0, subtile_width, subtile_height)
	target.blit_rect(subtiles[top_left], rect, Vector2i(x, y))
	target.blit_rect(subtiles[top_right], rect, Vector2i(x + subtile_width, y))
	target.blit_rect(subtiles[bottom_left], rect, Vector2i(x, y + subtile_height))
	target.blit_rect(subtiles[bottom_right], rect, Vector2i(x + subtile_width, y + subtile_height))


func update_subtile_resolution(img: Image) -> void:
	subtile_width = img.get_width() / AUTOTILE[mode + frame][CELLS_HORIZONTAL] / 2
	subtile_height = img.get_height() / AUTOTILE[mode + frame][CELLS_VERTICAL] / 2
	if mode > MODE.CLASSIC:
		subtile_height /= 2
		subtile_width /= 2


func create_subtiles(img: Image) -> Dictionary:
	var subtiles: Dictionary = Dictionary()
	for key in AUTOTILE[mode + frame][SUBTILES].keys():
		var position: Vector2i = AUTOTILE[mode + frame][SUBTILES][key]
		subtiles[key] = img.get_region(Rect2i(
			position.x * subtile_width,
			position.y * subtile_height,
			subtile_width, subtile_height
		))
		subtiles[key].convert(Image.FORMAT_RGBA8)
	return subtiles


func get_next_power_of_2(x: int) -> int:
	return int(pow(2, ceil(log(x) / log(2))))

func create_autotile_image() -> Image:
	var width: int = subtile_width * 2 * (8 if square else 12)
	var height: int = subtile_height * 2 * (8 if square else 4)
	if power_of_2:
		width = get_next_power_of_2(width)
		height = get_next_power_of_2(height)
	return Image.create(width, height, mipmaps, Image.FORMAT_RGBA8)


func is_source_texture_valid() -> bool:
	if not source_texture:
		push_error("Source-Texture: not set")
		return false
	
	if source_texture.get_width() < AUTOTILE[mode + frame][MIN_WIDTH]:
		push_error("Source-Texture: Width < %d" % AUTOTILE[mode + frame][MIN_WIDTH])
		return false
	if source_texture.get_height() < AUTOTILE[mode + frame][MIN_HEIGHT]:
		push_error("Source-Texture: Height < %d " % AUTOTILE[mode + frame][MIN_HEIGHT])
		return false
	
	if source_texture.get_width() % AUTOTILE[mode + frame][CELLS_HORIZONTAL]:
		push_error("Source-Texture: Width not divisible by %d" % AUTOTILE[mode + frame][CELLS_HORIZONTAL])
		return false
	if source_texture.get_width() % AUTOTILE[mode + frame][CELLS_VERTICAL]:
		push_error("Source-Texture: Height not divisible by %d" % AUTOTILE[mode + frame][CELLS_VERTICAL])
		return false
	
	return true


func set_failure_texture() -> void:
	var img: Image = create_autotile_image()
	img.fill(Color.MAGENTA)
	set_image(img)


func blit_first_part(img: Image, sub: Dictionary) -> void:
	# Vertical
	blit_tile(img, sub, 0, 0,
			OUTER_TOP_LEFT_TOP_LEFT, OUTER_TOP_RIGHT_TOP_RIGHT,
			OUTER_TOP_LEFT_BOTTOM_LEFT, OUTER_TOP_RIGHT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 0, 1,
			EDGE_LEFT_TOP_LEFT, EDGE_RIGHT_TOP_RIGHT,
			EDGE_LEFT_BOTTOM_LEFT, EDGE_RIGHT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 0, 2,
			OUTER_BOTTOM_LEFT_TOP_LEFT, OUTER_BOTTOM_RIGHT_TOP_RIGHT,
			OUTER_BOTTOM_LEFT_BOTTOM_LEFT, OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT)
	
	# Single
	blit_tile(img, sub, 0, 3,
			OUTER_TOP_LEFT_TOP_LEFT, OUTER_TOP_RIGHT_TOP_RIGHT,
			OUTER_BOTTOM_LEFT_BOTTOM_LEFT, OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT)
	
	# Horizontal
	blit_tile(img, sub, 1, 3,
			OUTER_TOP_LEFT_TOP_LEFT, OUTER_TOP_LEFT_TOP_RIGHT,
			OUTER_BOTTOM_LEFT_BOTTOM_LEFT, OUTER_BOTTOM_LEFT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 2, 3,
			EDGE_TOP_TOP_LEFT, EDGE_TOP_TOP_RIGHT,
			EDGE_BOTTOM_BOTTOM_LEFT, EDGE_BOTTOM_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 3, 3,
			OUTER_TOP_RIGHT_TOP_LEFT, OUTER_TOP_RIGHT_TOP_RIGHT,
			OUTER_BOTTOM_RIGHT_BOTTOM_LEFT, OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT)
	
	# Cross Row 1
	blit_tile(img, sub, 1, 0,
			OUTER_TOP_LEFT_TOP_LEFT, OUTER_TOP_LEFT_TOP_RIGHT,
			OUTER_TOP_LEFT_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 2, 0,
			EDGE_TOP_TOP_LEFT, EDGE_TOP_TOP_RIGHT,
			INNER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 3, 0,
			OUTER_TOP_RIGHT_TOP_LEFT, OUTER_TOP_RIGHT_TOP_RIGHT,
			INNER_BOTTOM_LEFT, OUTER_TOP_RIGHT_BOTTOM_RIGHT)
	
	# Cross Row 2
	blit_tile(img, sub, 1, 1,
			EDGE_LEFT_TOP_LEFT, INNER_TOP_RIGHT,
			EDGE_LEFT_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 2, 1,
			INNER_TOP_LEFT, INNER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 3, 1,
			INNER_TOP_LEFT, EDGE_RIGHT_TOP_RIGHT,
			INNER_BOTTOM_LEFT, EDGE_RIGHT_BOTTOM_RIGHT)

	# Cross Row 3
	blit_tile(img, sub, 1, 2,
			OUTER_BOTTOM_LEFT_TOP_LEFT, INNER_TOP_RIGHT,
			OUTER_BOTTOM_LEFT_BOTTOM_LEFT, OUTER_BOTTOM_LEFT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 2, 2,
			INNER_TOP_LEFT, INNER_TOP_RIGHT,
			EDGE_BOTTOM_BOTTOM_LEFT, EDGE_BOTTOM_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 3, 2,
			INNER_TOP_LEFT, OUTER_BOTTOM_RIGHT_TOP_RIGHT,
			OUTER_BOTTOM_RIGHT_BOTTOM_LEFT, OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT)


func blit_second_part(img: Image, sub: Dictionary) -> void:
	# Corners
	blit_tile(img, sub, 4, 0,
			CENTER_TOP_LEFT, INNER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 7, 0,
			INNER_TOP_LEFT, CENTER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 4, 3,
			INNER_TOP_LEFT, INNER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 7, 3,
			INNER_TOP_LEFT, INNER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	# Left
	blit_tile(img, sub, 4, 1,
			EDGE_LEFT_TOP_LEFT, INNER_TOP_RIGHT,
			EDGE_LEFT_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 4, 2,
			EDGE_LEFT_TOP_LEFT, CENTER_TOP_RIGHT,
			EDGE_LEFT_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	# Right
	blit_tile(img, sub, 7, 1,
			INNER_TOP_LEFT, EDGE_RIGHT_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, EDGE_RIGHT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 7, 2,
			CENTER_TOP_LEFT, EDGE_RIGHT_TOP_RIGHT,
			INNER_BOTTOM_LEFT, EDGE_RIGHT_BOTTOM_RIGHT)
	
	# Top
	blit_tile(img, sub, 5, 0,
			EDGE_TOP_TOP_LEFT, EDGE_TOP_TOP_RIGHT,
			INNER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 6, 0,
			EDGE_TOP_TOP_LEFT, EDGE_TOP_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	# Bottom
	blit_tile(img, sub, 5, 3,
			INNER_TOP_LEFT, CENTER_TOP_RIGHT,
			EDGE_BOTTOM_BOTTOM_LEFT, EDGE_BOTTOM_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 6, 3,
			CENTER_TOP_LEFT, INNER_TOP_RIGHT,
			EDGE_BOTTOM_BOTTOM_LEFT, EDGE_BOTTOM_BOTTOM_RIGHT)
	
	# Inner
	blit_tile(img, sub, 5, 1,
			INNER_TOP_LEFT, CENTER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 6, 1,
			CENTER_TOP_LEFT, INNER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 5, 2,
			CENTER_TOP_LEFT, CENTER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, 6, 2,
			CENTER_TOP_LEFT, CENTER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)


func blit_third_part(img: Image, sub: Dictionary) -> void:
	var x: int = 8 * int(not square)
	var y: int = 4 * int(square)
	# Corners
	blit_tile(img, sub, x, y,
			OUTER_TOP_LEFT_TOP_LEFT, OUTER_TOP_LEFT_TOP_RIGHT,
			OUTER_TOP_LEFT_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)

	blit_tile(img, sub, x + 3, y,
			OUTER_TOP_RIGHT_TOP_LEFT, OUTER_TOP_RIGHT_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, OUTER_TOP_RIGHT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, x, y + 3,
			OUTER_BOTTOM_LEFT_TOP_LEFT, CENTER_TOP_RIGHT,
			OUTER_BOTTOM_LEFT_BOTTOM_LEFT, OUTER_BOTTOM_LEFT_BOTTOM_RIGHT)

	blit_tile(img, sub, x + 3, y + 3,
			CENTER_TOP_LEFT, OUTER_BOTTOM_RIGHT_TOP_RIGHT,
			OUTER_BOTTOM_RIGHT_BOTTOM_LEFT, OUTER_BOTTOM_RIGHT_BOTTOM_RIGHT)
		
	# Clean Edges
	blit_tile(img, sub, x, y + 1, # Left
			EDGE_LEFT_TOP_LEFT, CENTER_TOP_RIGHT,
			EDGE_LEFT_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
			
	blit_tile(img, sub, x + 3, y + 2, # Right
			CENTER_TOP_LEFT, EDGE_RIGHT_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, EDGE_RIGHT_BOTTOM_RIGHT)
	
	blit_tile(img, sub, x + 2, y, # Top
			EDGE_TOP_TOP_LEFT, EDGE_TOP_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
			
	blit_tile(img, sub, x + 1, y + 3, # Bottom
			CENTER_TOP_LEFT, CENTER_TOP_RIGHT,
			EDGE_BOTTOM_BOTTOM_LEFT, EDGE_BOTTOM_BOTTOM_RIGHT)
	
	# Pointy Edges
	blit_tile(img, sub, x, y + 2, # Left
			INNER_TOP_LEFT, CENTER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
			
	blit_tile(img, sub, x + 3, y + 1, # Right
			CENTER_TOP_LEFT, INNER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	blit_tile(img, sub, x + 1, y, # Top
			INNER_TOP_LEFT, INNER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
			
	blit_tile(img, sub, x + 2, y + 3, # Bottom
			CENTER_TOP_LEFT, CENTER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
	
	# Diagonal
	blit_tile(img, sub, x + 1, y + 1,
			INNER_TOP_LEFT, CENTER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, INNER_BOTTOM_RIGHT)
			
	blit_tile(img, sub, x + 2, y + 2,
			CENTER_TOP_LEFT, INNER_TOP_RIGHT,
			INNER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
	
	# Full
	blit_tile(img, sub, x + 1, y + 2,
			CENTER_TOP_LEFT, CENTER_TOP_RIGHT,
			CENTER_BOTTOM_LEFT, CENTER_BOTTOM_RIGHT)
