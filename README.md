<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

This package provides easy dart language access to the uniforms in a ShaderProgram
using a similar API to the GPU types.

## Features

This package provides Dart classes to set the uniforms of a shader object using
common GPU type syntax, such as:

```dart
  var uColor = Vec4.fromIndex(shader, uColorIndex);
  var uPos = Vec2.fromName(shader, 'uPos');
  uColor.color = Colors.red;
  uPos.xy = Offset(10, 15);
```

where uColorIndex is the index of the uniform in the `.frag` file and `uPos` is the name
of a uniform used in the `.frag` file.

## Getting started

To install this package in your Flutter project, add the following lines to the
dependencies section in your `pubspec.yaml`:

```yaml
  shader_uniforms:
    git: https://github.com/flar/shader_uniforms.git
```

As an example, if your shader looks like this:

```
#include <flutter/runtime_effect.glsl>

uniform vec4 uColor;
uniform float uScale;

out vec4 fragColor;

void main() {
  vec2 pos = FlutterFragCoord();

  fragColor = vec4(
    mod(uColor.r - pos.x * uScale, 1.0),
    mod(uColor.g - pos.y * uScale, 1.0),
    mod(uColor.b - (pos.x + pos.y) * uScale, 1.0),
    uColor.a
  );
}
```

Then you can use, for instance, a CustomPainter.paint method like this:

```dart
  @override
  void paint(Canvas canvas, Size size) {
    var shader = myProgram.shaderProgram();
    var uColor = Vec4.fromName(shader, 'uColor');
    // Or, uColor = UniformVec4(shader, 0);
    uColor.color = Colors.green;
    shader.setFloat(4, scale);

    Paint p = Paint()
      ..shader = myShader.shader;

    canvas.drawRect(Offset.zero & size, p);
  }
```

You could also write a prototype class that would hide all of this
in a single implementation class, such as:

```dart
import 'dart:ui';

import 'package:shader_prototypes/shader_prototypes.dart';

class MyShader {
  MyShader() : shader = _program!.fragmentShader();

  final FragmentShader shader;

  late final Vec4 uColor = Vec4.fromIndex(shader, 0); // or from name

  double _uScale = 0.0;
  set uScale(double value) {
    _uScale = value;
    shader.setFloat(4, value);
  }
  double get uScale => _uScale;

  static FragmentProgram? _program;
  static Future<void> init() async {
    _program = await FragmentProgram.fromAsset('shaders/my_shader.frag');
  }
}
```

which could be used as:

```dart
  @override
  void paint(Canvas canvas, Size size) {
    final MyShader myShader = MyShader()
      ..uColor.color = color
      ..uScale = scale;

    Paint p = Paint()
      ..shader = myShader.shader;

    canvas.drawRect(Offset.zero & size, p);
  }
```
