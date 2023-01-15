@tool
class_name RMUChipSet
extends Resource

var _possibilities: Dictionary = Dictionary()

@export var square: bool = true:
	set(new_square):
		var new_possibilities = _RMU.get_possible_makers(chipset, new_square)
		if new_possibilities.size() == 0 and chipset:
			return
		square = new_square
		_possibilities = new_possibilities
		chipset_updated()

@export var chipset: Texture2D:
	set(new_chipset):
		chipset = new_chipset
		_possibilities = _RMU.get_possible_makers(chipset, square)
		if _possibilities.size() == 0:
			_possibilities = _RMU.get_possible_makers(chipset, false)
			if _possibilities.size() == 0:
				chipset = null
				chipset_updated()
				return
			square = false
		chipset_updated()


		
var maker: String = "INVALID":
	set(new_maker):
		if maker in _RMU.DATABASE.keys() and new_maker != "INVALID":
			maker = new_maker
			_set_property_hint("type", _possibilities[maker].keys())
			type = _possibilities[maker].keys()[0]
			_show_property("maker")
		else:
			maker = "INVALID"
			type = ""
			_hide_property("maker")

var type: String = "INVALID":
	set(new_type):
		if new_type in _RMU.DATABASE[maker]["TYPES"].keys() and new_type != "INVALID":
			type = new_type
			var sizes: PackedStringArray = PackedStringArray()
			for size in _possibilities[maker][type]:
				sizes.append("%d x %d" % [size.x, size.y])
			_set_property_hint("tilesize", sizes)
			_tilesize = _possibilities[maker][type][-1]
			_show_property("type")
		else:
			type = "INVALID"
			_hide_property("type")

var _tilesize: Vector2i = Vector2i.ZERO:
	set(new_tilesize):
		if Vector2(new_tilesize) in _possibilities[maker][type]:
			if _tilesize != new_tilesize:
				_tilesize = new_tilesize
				tilesize = "%d x %d" % [_tilesize.x, _tilesize.y]
			_show_property("tilesize")
		else:
			_tilesize = Vector2i.ZERO
			tilesize = "INVALID"
			_hide_property("tilesize")

var tilesize: String = "1x1":
	set(new_tilesize):
		if new_tilesize == "INVALID":
			_hide_property("tilesize")
			return
		var parts: PackedStringArray = new_tilesize.replace(" ", "").split("x")
		if not parts.size() == 2 or not parts[0].is_valid_int() or not parts[1].is_valid_int():
			push_error("Invalid tilesize")
			_hide_property("tilesize")
			return
		tilesize = new_tilesize
		_show_property("tilesize")
		_tilesize = Vector2i(parts[0].to_int(), parts[1].to_int())
		
var autotiles: Array = Array():
	set(new_autotiles):
		autotiles = new_autotiles
		if autotiles.size() > 0:
			_show_property("autotiles")
		else:
			_hide_property("autotiles")

var props: Dictionary = {
	"maker": {
		"name": "maker",
		"class_name": &"",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",",
		"usage": PROPERTY_USAGE_SCRIPT_VARIABLE,
	},
	"type": {
		"name": "type",
		"class_name": &"",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "",
		"usage": PROPERTY_USAGE_SCRIPT_VARIABLE,
	},
	"tilesize": {
		"name": "tilesize",
		"class_name": &"",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "",
		"usage": PROPERTY_USAGE_SCRIPT_VARIABLE,
	},
	"autotiles": { 
		"name": "autotiles",
		"class_name": &"",
		"type": TYPE_ARRAY,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"usage": PROPERTY_USAGE_SCRIPT_VARIABLE | PROPERTY_USAGE_READ_ONLY,
	},
}


func _add_property_usage(prop: String, usage: int) -> void:
	if not prop in props:
		push_error("Property %s not found" % prop)
		return
	props[prop]["usage"] |= usage
	notify_property_list_changed()


func _remove_property_usage(prop: String, usage: int) -> void:
	if not prop in props:
		push_error("Property %s not found" % prop)
		return
	props[prop]["usage"] &= ~usage
	notify_property_list_changed()


func _show_property(prop: String) -> void:
	_add_property_usage(prop, PROPERTY_USAGE_EDITOR)


func _hide_property(prop: String) -> void:
	_remove_property_usage(prop, PROPERTY_USAGE_EDITOR)


func _set_property_hint(prop: String, hints: PackedStringArray) -> void:
	if not prop in props:
		push_error("Property %s not found" % prop)
		return
	props[prop]["hint_string"] = ",".join(hints)
	notify_property_list_changed()


func _get_property_list() -> Array:
	return props.values()


func chipset_updated() -> void:
	
	if chipset:
		_possibilities = _RMU.get_possible_makers(chipset, square)
		_set_property_hint("maker", _possibilities.keys())
		var m: Dictionary =  _RMU.guess_type(chipset, square)
		maker = m["MAKER"]
		type = m["TYPE"]
		_tilesize = _possibilities[maker][type][0]
		#autotiles = _RMUConv.slice(chipset, _tilesize, 
		#	_RMU.DATABASE["CUSTOM"]["TYPES"][type]["SIZE"] / 2,
		#	false)
		#autotiles = _RMUConv.convert_classic_autotile_slices(autotiles, false)

		autotiles = _RMUConv.slice_autoblocks(chipset, _tilesize, false)["BLOCKTILES"]
	else:
		maker = "INVALID"
		type = "INVALID"
		tilesize = "INVALID"
		autotiles = Array()
