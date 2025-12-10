// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:shader_uniforms/shader_uniforms.dart';
import 'package:shader_uniforms/src/named_uniform_vec4.dart';

/// A utility class to manage the uniform fields of a `mat4` uniform in
/// a shader `.frag` file.
///
/// This class also subclasses the base Mat4 object providing read and write
/// access to the data. Though the data is not fetched from the shader and
/// instead is remembered by the base class which means the data can get out
/// of sync if multiple Mat4 objects are instantiated with the same shader
/// and name, or if the shader uniforms are set using other means.
/// If this class is used to manage shader uniform data, then no other
/// mechanisms should be used to modify that uniform data.
///
/// See also:
///
/// * [FragmentShader.getUniformFloat] which provides the base access to
///   the named uniform in the [shader] object.
class NamedUniformMat4 extends Mat4 {
  /// Instantiate a wrapper that will provide column-by-column access to
  /// the mat4 of the indicatd [shader] with the indicated [name] using
  /// indexing to provide per-column [UniformVec4] objects, which also
  /// then provide a 2D matrix indexing through the indexing accessors
  /// of the [UniformVec4] class.
  ///
  /// ```dart
  ///    UniformMat4 mat
  ///    // These 2 lines do the same thing.
  ///    mat[0].x = 2.0;   // Sets the x value of the first column
  ///    mat[0][0] = 2.0;  // Sets the upper left corner of the matrix
  /// ```
  ///
  /// See also:
  ///
  /// * [FragmentShader.getUniformFloat] which provides the base access to
  ///   the named uniform in the [shader] object.
  NamedUniformMat4({
    required this.shader,
    required this.name,
    this.offset = 0,
  })
      : super.using(
    NamedUniformVec4(shader: shader, name: name, offset: offset + 0),
    NamedUniformVec4(shader: shader, name: name, offset: offset + 4),
    NamedUniformVec4(shader: shader, name: name, offset: offset + 8),
    NamedUniformVec4(shader: shader, name: name, offset: offset + 12),
  );

  /// The [FragmentShader] instance in which the associated mat4 is a uniform.
  final FragmentShader shader;
  /// The name of the associated vec2 uniform defined within the shader.
  final String name;
  /// An additional offset from the named uniform defined within the shader,
  /// useful for when the vec2 is in an array.
  final int offset;
}
