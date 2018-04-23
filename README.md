
# BrainFuck IDE

BF IDE with visualization, step by step execution, breakpoints, examples, and syntax highlighting. Made with Godot.
# [Try online now!](https://nodesource.com/products/nsolid)

![DEMO GIF](https://gabrii.github.io/BrainFuckIDE/screencap.gif)


# About
  - Insprited by [@fatiherikli]()'s [Brainfuck Visualizer](https://github.com/fatiherikli/brainfuck-visualizer/).
  - Font [Graph +35](http://www.1001fonts.com/graph-35-pix-font.html) by [30100flo](http://www.1001fonts.com/users/30100flo/).
  - Most BrainFuck examples from [Daniel B Cristofani](http://www.hevanet.com/cristofd/brainfuck/), and some from [Jeff Johnston Archive](http://esoteric.sange.fi/brainfuck/README.txt).
  - [Monokai](https://www.monokai.pro/) color schema for syntax highlighting.
  - Made with Godot 3.0.2.

# Limitations

I stumbled into 2 Godot bugs that made impossible to get the desired effect. I've made pull requests fixing those, but are pending to merge:
 - [#18298](https://github.com/godotengine/godot/pull/18298) Text edit didn't work when scaling display.
 - [#18028](https://github.com/godotengine/godot/pull/18028) Couldn't activate TextEdit's builtin breakpoint gutter.

I also have modified, rather in a hackish way, *TextEdit.cpp* to allow me to set syntax highlighting keywords with this characteristics:
 - Length 1
 - Happen to be symbols.
 - Are directly next to another keyword, without space or separataion.

If you want to fork the repo and get the same result, I recommend you to use the [*brainfuck_ide* branch on my godot fork](https://github.com/gabrii/godot/tree/brainfuck_ide). It includes both bug fixes and the syntax highlighting changes. Keep in mind that you will need to [compile the export templates](http://docs.godotengine.org/en/3.0/development/compiling/index.html) to export the project with these changes. I've only tested it on android, web assembly, and x11. I have a WIP for an android keyboard:

![KEYBOARD WIP](https://gabrii.github.io/BrainFuckIDE/mobile_keyboard.png)

Other limitations include the speed. The interpreter is written in GDScript, which itself is an interpreted language. In order to get better performance, atleast on the minimum delay setting, a C brainfuck interpreter should be written in GDNative.


And sadly, godot builds for HTML5 don't share the system clipboard, which makes an IDE quite useless, as you can't copy what you develop to paste it somewhere.... And [the issue](https://github.com/godotengine/godot/issues/12587) discussing this hasn't had any activity for a few months. It has to do with EMScripten and browser security, it probably won't be fixed in a long time. Hyperlinks don't work either, otherwise a workaround could be easily implemented. This limitations are what makes me see Godot's web build as a great tool for games, but horrible for some non-game applications, where it could have very interesting use cases. It's an amazing WebGL and WebASM "framework", without any of the low level hassle.

---

Distributed under GNU General Public License v3.0
Gabriel Gavilan 2018
