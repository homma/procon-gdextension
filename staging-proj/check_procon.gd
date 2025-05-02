extends MeshInstance3D

var last_printed = 0.0

func _process(delta):
    last_printed += delta
    if(last_printed > 1.0):
        last_printed = 0.0
        print_procon()

    var q = GlobalProcon.get_quaternion()
    self.quaternion = q
 
func print_procon():
    print("reading procon...")

    # get values
    var q = GlobalProcon.get_quaternion()
    var w = str(q.w)
    var x = str(q.x)
    var y = str(q.y)
    var z = str(q.z)

    var bt_up = GlobalProcon.is_button_pressed(JOY_BUTTON_DPAD_UP)
    var bt_down = GlobalProcon.is_button_pressed(JOY_BUTTON_DPAD_DOWN)
    var bt_left = GlobalProcon.is_button_pressed(JOY_BUTTON_DPAD_LEFT)
    var bt_right = GlobalProcon.is_button_pressed(JOY_BUTTON_DPAD_RIGHT)
    var bt_a = GlobalProcon.is_button_pressed(JOY_BUTTON_B)
    var bt_b = GlobalProcon.is_button_pressed(JOY_BUTTON_A)
    var bt_x = GlobalProcon.is_button_pressed(JOY_BUTTON_Y)
    var bt_y = GlobalProcon.is_button_pressed(JOY_BUTTON_X)
    var bt_l = GlobalProcon.is_button_pressed(JOY_BUTTON_LEFT_SHOULDER)
    var bt_r = GlobalProcon.is_button_pressed(JOY_BUTTON_RIGHT_SHOULDER)
    var bt_l_stick = GlobalProcon.is_button_pressed(JOY_BUTTON_LEFT_STICK)
    var bt_r_stick = GlobalProcon.is_button_pressed(JOY_BUTTON_RIGHT_STICK)
    var bt_plus = GlobalProcon.is_button_pressed(JOY_BUTTON_START)
    var bt_minus = GlobalProcon.is_button_pressed(JOY_BUTTON_BACK)
    var bt_home = GlobalProcon.is_button_pressed(JOY_BUTTON_GUIDE)
    var bt_capture = GlobalProcon.is_button_pressed(JOY_BUTTON_MISC1)

    var bt_zl = GlobalProcon.is_zbutton_pressed(JOY_AXIS_TRIGGER_LEFT)
    var bt_zr = GlobalProcon.is_zbutton_pressed(JOY_AXIS_TRIGGER_RIGHT)

    var st_l_x = GlobalProcon.get_axis(JOY_AXIS_RIGHT_X)
    var st_l_y = GlobalProcon.get_axis(JOY_AXIS_RIGHT_Y)
    var st_r_x = GlobalProcon.get_axis(JOY_AXIS_LEFT_X)
    var st_r_y = GlobalProcon.get_axis(JOY_AXIS_LEFT_Y)

    # print
    print("w: " + w)
    print("x: " + x)
    print("y: " + y)
    print("z: " + z)
        
    print("Up: " + str(bt_up))
    print("Down: " + str(bt_down))
    print("Left: " + str(bt_left))
    print("Right: " + str(bt_right))
    print("A: " + str(bt_a))
    print("B: " + str(bt_b))
    print("X: " + str(bt_x))
    print("Y: " + str(bt_y))
    print("L: " + str(bt_l))
    print("R: " + str(bt_r))
    print("LS: " + str(bt_l_stick))
    print("RS: " + str(bt_r_stick))
    print("+: " + str(bt_plus))
    print("-: " + str(bt_minus))
    print("Home: " + str(bt_home))
    print("Capture: " + str(bt_capture))

    print("ZL : " + str(bt_zl))
    print("ZR : " + str(bt_zr))

    print("SLX: " + str(st_l_x))
    print("SLY: " + str(st_l_y))
    print("SRX: " + str(st_r_x))
    print("SRY: " + str(st_r_y))
