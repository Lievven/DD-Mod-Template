extends Node2D
class_name ModPersistence


var editor
var mod_entry

var map_settings: Dictionary
var user_settings: Dictionary


func _init(entry):
    mod_entry = entry
    editor = mod_entry.Global.Editor
    editor.connect("OnSaveBegin", self, "save")
    editor.add_child(self)

    
func _notification(notification: int) -> void:
    if not notification == NOTIFICATION_WM_QUIT_REQUEST:
        return
    save_user_settings()


## Saves the user settings as JSON in the MOD_DATA_PATH
func save_user_settings(data: Dictionary = {}):
    # Opening/creating of the actual file and writing of the data here.
    var file = File.new()
    file.open(mod_entry.MOD_DATA_PATH, File.WRITE)
    file.store_line(JSON.print(data, "\t"))
    file.close()

    # Currently I simply save any change to both the map and the general settings.
    # In the future I may only want to save changes locally, and only update global settings from elsewhere.
    save_local_settings(false)
    print("[%s] Saving global user settings: successful" % mod_entry.MOD_DISPLAY_NAME)


## Loads the user settings from the MOD_DATA_PATH
## If there is no file in the specified location, we stop the attempt and leave the default values as they are.
func load_user_settings():
    var file = File.new()
    var error = file.open(mod_entry.MOD_DATA_PATH, File.READ)
    
    # If we cannot read the file, stop this attempt and leave the respective values at their default.
    if error != 0:
        print("[%s] Loading global user settings: no valid file found" % mod_entry.MOD_DISPLAY_NAME)
        return

    # Loading, parsing, and closing the file.
    var line = file.get_as_text()
    var data = JSON.parse(line).result
    file.close()

    # Writing user settings back where they belong.
    settings_from_dictionary(data)
    print("[%s] Loading global user settings: successful" % mod_entry.MOD_DISPLAY_NAME)


# Saves the current user settings into the mod data of the map that is being worked on.
func save_map_settings(data: Dictionary):
    Global.ModMapData[mod_entry.TOOL_ID] = data
    print("[%s] Saving local map settings: successful" % mod_entry.MOD_DISPLAY_NAME)


# Loads the user settings of the current map.
func load_map_settings():
    var data = Global.ModMapData[mod_entry.TOOL_ID]
    if data == null or data.empty():
        print("[%s] Loading user map settings: no valid file found" % mod_entry.MOD_DISPLAY_NAME)
        return
    settings_from_dictionary(data)
    print("[%s] Loading user map settings: successful" % mod_entry.MOD_DISPLAY_NAME)