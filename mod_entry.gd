var script_class = "tool"
# Your script class tells Dungeondraft whether your mod is:
# 1. Building or extending a tool (script_class = "tool")
# 2. Creating a new export format (script_class = "export_format")

const SCRIPT_PATH = "scripts/"
const MOD_DISPLAY_NAME = "Mod Template"

var DemoClass
var ModPersistence
var has_updated = false

var mod_persistence


func start():
    print("[%s] starting" % MOD_DISPLAY_NAME)
    
    # Loading an example class
    #DemoClass = load_mod_class(SCRIPT_PATH + "demo_class.gd")
    ModPersistence = load_mod_class(SCRIPT_PATH + "mod_persistence.gd")

    # Showing that the loaded class works. Replace with your own code.
    if DemoClass:
        print("Demo Class")
        var demo_class_instance = DemoClass.new()
        demo_class_instance.demo_function()

    if ModPersistence:
        print("Mod Persistence")
        mod_persistence = ModPersistence.new(self)
    else:
        print("Fail")


func update(delta):
    if not has_updated:
        has_updated = true
        print("[%s] updating" % MOD_DISPLAY_NAME)


func load_mod_class(class_path):
    var class_variable = ResourceLoader.load(Global.Root + class_path, "GDScript", false)

    if class_variable:
        print("[%s] Successfully loaded class script: [%s]" % [MOD_DISPLAY_NAME, class_path])
    else:
        print("[%s] Failed to load class script: [%s]" % [MOD_DISPLAY_NAME, class_path])

    return class_variable




## Debug function, prints signals of the given node
func print_signals(node):
    print("========= PRINTING SIGNALS OF %s ==========" % node.name)
    var signal_list = node.get_signal_list()
    for sig in signal_list:
        print(sig.name)