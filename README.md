
#### About

A GDExtension library to use Pro Controller from Godot.

#### Prerequisites

- [Godot](https://github.com/godotengine/godot) 4.x
- [SDL3](https://github.com/libsdl-org/SDL)
- [SCons](https://github.com/SCons/scons)

#### How to build

Install required packages.

````console
$ brew install -y sdl3 scons
````

Clone this repository.

````console
$ git clone https://github.com/homma/procon-gdextension.git
````

Add required libraries.

````console
$ cd procon-gdextension
$ git clone --depth 1 -b 4.4 https://github.com/godotengine/godot-cpp.git
$ git clone --depth 1 https://github.com/homma/proconlib.git
$ git clone --depth 1 https://github.com/JibbSmart/GamepadMotionHelpers.git
````

Build the software.

````console
$ ./task/build.sh
````

You can run a project as below for a test.

````console
$ godot staging-proj/project.godot
````

The editor script `create_scene.gd` creates test scenes.  
The newly created scenes demonstrate the usage of the library.
