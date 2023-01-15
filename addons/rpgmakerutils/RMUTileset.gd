@tool
class_name RMUTileSet
extends TileSet

@export var _update: bool = false:
	set(__):
		update()

@export var classic_chipsets: Array[Texture2D]

func update() -> void:
	var ids: Array = range(classic_chipsets.size())
	var source_ids: Array = 
	for i in get_source_count():
		var id: int = get_source_id(i)
		var source: TileSetAtlasSource = get_source(id) as TileSetAtlasSource
		if not source or not source.has_meta("__RMU__"):
			continue
		source_ids.append(id)
	
	for id in source_ids:
		var source: TileSetAtlasSource = get_source(id) as TileSetAtlasSource
		if not source.get_meta("RMU_ID") in ids:
			remove_source(id)
			continue
		
		
