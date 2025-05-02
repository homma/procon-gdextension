#pragma once

#include <godot_cpp/core/class_db.hpp>

using namespace godot;

auto initialize_procon_module(ModuleInitializationLevel p_level) -> void;
auto uninitialize_procon_module(ModuleInitializationLevel p_level) -> void;
