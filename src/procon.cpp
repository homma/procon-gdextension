#include "procon.h"
#include <SDL3/SDL.h>

#include <format>
#include <numbers>

#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

using namespace godot;

auto Procon::_bind_methods() -> void {
  ClassDB::bind_method(D_METHOD("get_quaternion"), &Procon::get_quaternion);
  ClassDB::bind_method(D_METHOD("is_button_pressed"),
                       &Procon::is_button_pressed);
  ClassDB::bind_method(D_METHOD("is_zbutton_pressed"),
                       &Procon::is_zbutton_pressed);
  ClassDB::bind_method(D_METHOD("get_axis"), &Procon::get_axis);
}

Procon::Procon() {
  if (not this->init_sdl()) {
    return;
  }

  this->scan();
}

Procon::~Procon() {
  // blank
}

auto Procon::_process(double delta) -> void { this->update(); }

auto Procon::scan() -> bool {
  auto exists = this->procon.scan();

  if (exists) {
    this->motion.SetCalibrationMode(
        GamepadMotionHelpers::CalibrationMode::Stillness |
        GamepadMotionHelpers::CalibrationMode::SensorFusion);
  } else {
    UtilityFunctions::print("Procon::scan failed.");
  }

  return exists;
}

auto Procon::update() -> bool {
  if (not this->procon.connected()) {
    if (not procon.scan()) {
      return false;
    }
  }

  auto updated = this->procon.update();

  if (updated) {

    // radian to degree
    // SDL reports gyro data in radian.
    //
    float r2d = 180.0 / std::numbers::pi;

    // SDL converts procon coordinates into playstation controller
    // coordinates inside its implementation.
    //
    // https://github.com/libsdl-org/SDL/blob/main/src/joystick/hidapi/SDL_hidapi_switch.c#L2291-L2294
    //
    this->motion.ProcessMotion(this->procon.gyro[0] * r2d, //
                               this->procon.gyro[1] * r2d, //
                               this->procon.gyro[2] * r2d, //
                               this->procon.accel[0],      //
                               this->procon.accel[1],      //
                               this->procon.accel[2],      //
                               this->procon.delta_time / 1000.0);
  }

  return updated;
}

auto Procon::get_quaternion() -> Quaternion {
  float w, x, y, z;

  this->motion.GetOrientation(w, x, y, z);

  return Quaternion{x, y, z, w};
}

auto Procon::is_button_pressed(int button) -> bool {
  return this->procon.is_button_pressed(static_cast<SDL_GamepadButton>(button));
}

auto Procon::is_zbutton_pressed(int axis) -> bool {
  return this->procon.is_zbutton_pressed(static_cast<SDL_GamepadAxis>(axis));
}

auto Procon::get_axis(int axis) -> int16_t {
  return this->procon.get_axis(static_cast<SDL_GamepadAxis>(axis));
}

auto Procon::init_sdl() -> bool {
  if (not SDL_Init(SDL_INIT_GAMEPAD)) {
    UtilityFunctions::print("SDL_INIT_GAMEPAD failed.");

    // disable processing
    set_process_mode(Node::ProcessMode::PROCESS_MODE_DISABLED);

    return false;
  }

  return true;
}
