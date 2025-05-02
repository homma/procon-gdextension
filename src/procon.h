#pragma once

#include <SDL3/SDL.h>
#include <proconlib/procon_manager.hpp>

#include <cstdlib>
// needs to include after cstdlib
#include <GamepadMotionHelpers/GamepadMotion.hpp>

#include <godot_cpp/classes/node.hpp>

namespace godot {

class Procon : public Node {
  GDCLASS(Procon, Node)

public:
  ProconManager procon;
  GamepadMotion motion;

  Procon();
  ~Procon();

  auto _process(double delta) -> void override;

  auto scan() -> bool;
  auto update() -> bool;

  auto get_quaternion() -> Quaternion;

  auto is_button_pressed(int button) -> bool;
  auto is_zbutton_pressed(int axis) -> bool;
  auto get_axis(int axis) -> int16_t;

protected:
  static void _bind_methods();

private:
  auto init_sdl() -> bool;

};

} // namespace godot
