class_name _RMU
extends Node

const DATABASE: Dictionary = {
	"MX": {
		"TILESIZE": Vector2i(48, 48),
		"TYPES": {
			"STANDARD": {
				"SIZE": Vector2i(768, 768),
			},
			"AUTOTILE_MODERN": {
				"SIZE": Vector2i(768, 576),
			},
			"AUTOWALL": {
				"SIZE": Vector2i(768, 384),
			},
			"AUTOBLOCK": {
				"SIZE": Vector2i(768, 720),
			},
		},
	},
	"VX": {
		"TILESIZE": Vector2i(32, 32),
		"TYPES": {
			"STANDARD": {
				"SIZE": Vector2i(256, 512),
			},
			"AUTOTILE_MODERN": {
				"SIZE": Vector2i(512, 384),
			},
			"AUTOWALL": {
				"SIZE": Vector2i(512, 256),
			},
			"AUTOBLOCK": {
				"SIZE": Vector2i(512, 480),
			},
		},
	},
	"XP": {
		"TILESIZE": Vector2i(32, 32),
		"TYPES": {
			"STANDARD": {
				"SIZE": Vector2i(256, 0),
			},
			"AUTOTILE_CLASSIC": {
				"SIZE": Vector2i(96, 128),
			},
			"ANIMATED_AUTOTILE": {
				"SIZE": Vector2i(384, 128),
			},
		},
	},
	"TWOK": {
		"TILESIZE": Vector2i(16, 16),
		"TYPES": {
			"STANDARD": {
				"SIZE": Vector2i(480, 256),
			},
		},
	},
	"CUSTOM": {
		"TILESIZE": Vector2i(2, 2),
		"TYPES": {
			"AUTOTILE_CLASSIC": {
				"SIZE": Vector2i(6, 8),
			},
			"AUTOTILE_MODERN": {
				"SIZE": Vector2i(4, 6),
			},
			"AUTOBLOCK": {
				"SIZE": Vector2i(4, 10),
			},
			"STANDARD": {
				"SIZE":  Vector2i(2, 2),
			},
			"AUTOWALL": {
				"SIZE": Vector2i(4, 4),
			},
		},
	},
	"INVALID": {
		"TILESIZE": Vector2i(1, 1),
		"TYPES": {
			"INVALID": {
				"SIZE": Vector2i(1, 1),
			},
		},
	},
}

static func is_dividable(width: int, height: int, divider_width: int, divider_height: int) -> bool:
	return width % divider_width == 0 and height % divider_height == 0


static func is_dividablev(size: Vector2i, divider_size: Vector2i) -> bool:
	return is_dividable(size.x, size.y, divider_size.x, divider_size.y)

# Refactor me
static func guess_type(texture: Texture2D, square: bool) -> Dictionary:
	if not texture:
		return Dictionary()
	var width: int = texture.get_width()
	var height: int = texture.get_height()
	for maker in DATABASE.keys():
		var tilesize: Vector2i = DATABASE[maker]["TILESIZE"]
		for type in DATABASE[maker]["TYPES"].keys():
			var guess: Vector2i = DATABASE[maker]["TYPES"][type]["SIZE"]
			if not maker == "CUSTOM":
				if guess.x == 0:
					if not width % tilesize.x == 0:
						continue
				else:
					if not width == guess.x:
						continue
						
				if guess.y == 0:
					if not height % tilesize.y == 0:
						continue
				else:
					if not height == guess.y:
						continue
			else:
				if not width % guess.x + height % guess.y == 0:
					continue
				if not square and width / guess.x == height / guess.y:
					continue
			return {
				"MAKER": maker,
				"TYPE": type,
			}
	return {
		"MAKER": "INVALID",
		"TYPE": "INVALID",
	}

static func _get_dividers(i : int, minimum: int = 0) -> PackedInt64Array:
	var output: PackedInt64Array = PackedInt64Array()
	output.append(i)
	for divider in range(i / 2, 0, -1):
		if i % divider == 0 and divider >= minimum:
			output.append(divider)
	output.reverse()
	return output.duplicate()


static func _square_dividers(a: PackedInt64Array, b: PackedInt64Array) -> PackedInt64Array:
	var output: PackedInt64Array = PackedInt64Array()
	for c in a:
		if c in b:
			output.append(c)
	return output.duplicate()


# Refactor me
static func get_possible_makers(texture: Texture2D, square: bool) -> Dictionary:
	if not texture:
		return Dictionary()
	var width: int = texture.get_width()
	var height: int = texture.get_height()
	var makers: Dictionary = Dictionary()
	for maker in DATABASE.keys():
		if maker == "INVALID":
			continue
		var tilesize: Vector2i = DATABASE[maker]["TILESIZE"]
		for type in DATABASE[maker]["TYPES"].keys():
			var type_size: Vector2i = DATABASE[maker]["TYPES"][type]["SIZE"]
			if not maker == "CUSTOM":
				if not width == type_size.x or not height == type_size.y:
					continue
				if not maker in makers:
					makers[maker] = Dictionary()
				if not type in makers[maker]:
					makers[maker][type] = PackedVector2Array()
				makers[maker][type].append(tilesize)
			else:
				if not width % type_size.x + height % type_size.y == 0:
					continue
				if not maker in makers:
					makers[maker] = Dictionary()
				if not type in makers[maker]:
					makers[maker][type] = PackedVector2Array()
				var possible_tile_widths: PackedInt64Array = _get_dividers(width / type_size.x, type_size.x)
				var possible_tile_heights: PackedInt64Array = _get_dividers(height / type_size.y, type_size.y)
				if type == "STANDARD":
					possible_tile_widths = _get_dividers(width, type_size.x)
					possible_tile_heights = _get_dividers(height, type_size.y)
				for x in possible_tile_widths:
					for y in possible_tile_heights:
						if square and x != y:
							continue
						makers[maker][type].append(Vector2i(x, y))
				if makers[maker][type].size() == 0:
					makers[maker].erase(type)
	return makers
