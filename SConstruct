import os
import sys

# Build Environment
env = SConscript("godot-cpp/SConstruct")
env = env.Clone()
env.Append(CCFLAGS=["-std=c++2c"])

env.Append(CPPPATH=["src/"])
sources = Glob("src/*.cpp")

# Library
## SDL3
env.ParseConfig("pkg-config sdl3 --libs-only-L --libs-only-l --cflags")

## proconlib
env.Append(CPPPATH=["."])

## GamepadMotionHelpers
env.Append(CPPPATH=["."])
env.Append(CCFLAGS=["-Wno-comment"])

# Shared Library
library = env.SharedLibrary(
    target="staging-proj/bin/libprocon.{}.{}.dylib".format(
        env["platform"], env["target"]
    ),
    source=sources,
)

# Default Build Target
Default(library)
