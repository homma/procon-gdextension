#include "register_types.h"

#include "procon.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

using namespace godot;

auto initialize_procon_module(ModuleInitializationLevel p_level) -> void {
  if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
    return;
  }

  GDREGISTER_RUNTIME_CLASS(Procon);
}

auto uninitialize_procon_module(ModuleInitializationLevel p_level) -> void {
  if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
    return;
  }
}

extern "C" {

GDExtensionBool GDE_EXPORT
procon_library_init(GDExtensionInterfaceGetProcAddress p_get_proc_address,
                    const GDExtensionClassLibraryPtr p_library,
                    GDExtensionInitialization *r_initialization) {

  godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library,
                                                 r_initialization);

  init_obj.register_initializer(initialize_procon_module);
  init_obj.register_terminator(uninitialize_procon_module);
  init_obj.set_minimum_library_initialization_level(
      MODULE_INITIALIZATION_LEVEL_SCENE);

  return init_obj.init();
}
}
