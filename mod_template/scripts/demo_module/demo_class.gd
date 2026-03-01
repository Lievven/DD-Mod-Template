extends Reference
# Why extend Reference?
# Reference & Node are the bottom-most extension of the Object class you'll need.
#
# Why not extend Object?
# The Object class does not keep a reference count.
# This means that you will have to manually free objects, leading to memory leaks if you fail to do so.
#
# When do I extend Node instead?
# Nodes are for adding to the scene tree. Use a Node if (but only if) you want to add it to the Scene Tree.
#
# What happens when I don't extend another class?
# Dungeondraft will automatically run any script file not starting with the 'extends' keyword.
# This may be desireable in some cases (most importantly the entry script must be loaded this way or your mod won't work).
# But you should only load files manually, unless you specifically want this behaviour.
#
# Note: 'extends' must be the first word in a file or not in the file at all, else Dungeondraft will throw an exception.

class_name DemoClass


var has_updated = false




func demo_function():
    print("You have successfully called the demo function.")


func start():
    print("This is the start() function in the demo class.")
    print("It should never be reached, as that means Dungeondraft is loading this class as a mod entry file.")


func update(delta):
    if has_updated:
        return
    has_updated = true
    print("This is the update() function in the demo class.")
    print("It should never be reached, as that means Dungeondraft is loading this class as a mod entry file.")