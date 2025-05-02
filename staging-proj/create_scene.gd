@tool
extends EditorScript

func _run():
    create_procon_scene()
    create_main_scene()

# create the main scene
func create_main_scene():

    # root node
    var node = ClassDB.instantiate("Node3D")
    node.set_name("root")
    node.show()

    # Mesh
    var mesh = ClassDB.instantiate("MeshInstance3D")
    mesh.set_name("mesh")
    mesh.set_position(Vector3(0, 2.5, 0))
    mesh.set_script(load("res://check_procon.gd"))

    var box_mesh = ClassDB.instantiate("BoxMesh")
    box_mesh.set_size(Vector3(1, 5, 3))
    mesh.set_mesh(box_mesh)

    var mat = ClassDB.instantiate("StandardMaterial3D")
    mat.set_albedo(Color(0, 0, 255, 255))
    mesh.set_surface_override_material(0, mat)

    node.add_child(mesh)
    mesh.set_owner(node)

    # Light
    var light = ClassDB.instantiate("DirectionalLight3D")
    light.set_position(Vector3(0.0, 5.0, -10.0))
    light.set_rotation(Vector3(deg_to_rad(-20.0), deg_to_rad(180.0), deg_to_rad(0.0)))

    node.add_child(light)
    light.set_owner(node)

    # Camera
    var camera = ClassDB.instantiate("Camera3D")
    camera.set_position(Vector3(0.0, 3.0, -8.0))
    camera.set_rotation(Vector3(deg_to_rad(-3.0), deg_to_rad(180.0), deg_to_rad(0.0)))

    node.add_child(camera)
    camera.set_owner(node)

    create_scene_from_node(node, "check_procon")

# create a scene from Procon and make it an autoload singleton
func create_procon_scene():
    var procon = ClassDB.instantiate("Procon")
    procon.set_name("Procon")

    var path = create_scene_from_node(procon, "Procon")

    var ep = EditorPlugin.new()
    ep.add_autoload_singleton("GlobalProcon", path)

# create a scene from a node
func create_scene_from_node(root_node, scene_name):
    # PackedScene
    var scn = PackedScene.new()
    scn.pack(root_node)

    # generate a file path to store a scene
    var path = "res://" + scene_name + ".tscn"

    var n = 0
    while FileAccess.file_exists(path):
        n += 1
        path = "res://" + scene_name + str(n) + ".tscn"

    # save the PackedScene
    ResourceSaver.save(scn, path)

    # open the PackedScene in the editor
    EditorInterface.open_scene_from_path(path)

    return path
