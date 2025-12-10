// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:shader_uniforms/shader_uniforms.dart';

/// A utility class to manage the uniform fields of a `vec4` uniform in
/// a shader `.frag` file.
///
/// This class also subclasses the base Vec4 object providing read and write
/// access to the data. Though the data is not fetched from the shader and
/// instead is remembered by the base class which means the data can get out
/// of sync if multiple UniformVec3 objects are instantiated with the same
/// shader and name, or if the shader uniforms are set using other means.
/// If this class is used to manage shader uniform data, then no other
/// mechanisms should be used to modify that uniform data.
///
/// See also:
///
/// * [FragmentShader.getUniformFloat] which provides the base access to
///   the named uniform in the [shader] object.
class NamedUniformVec4 extends Vec4 {
  /// Instantiate a wrapper that will manipulate the vec2 fields on the
  /// uniform identified by [name] in the indicated [FragmentShader].
  /// An optional offset parameter may be used to specify an additional
  /// offset for the case where the vec4 field is in an array.
  ///
  /// See also:
  ///
  /// * [FragmentShader.getUniformFloat] which provides the base access to
  ///   the named uniform in the [shader] object.
  NamedUniformVec4({
    required this.shader,
    required this.name,
    this.offset = 0,
  })
      : _setter = shader.getUniformFloat(name);

  /// Set the x sub-field of the associated vec4 uniform.
  @override
  set x(double x) {
    super.x = x;
    shader.setFloat(_setter.index + offset + 0, x);
  }

  /// Set the y sub-field of the associated vec4 uniform.
  @override
  set y(double y) {
    super.y = y;
    shader.setFloat(_setter.index + offset + 1, y);
  }

  /// Set the z sub-field of the associated vec4 uniform.
  @override
  set z(double z) {
    super.z = z;
    shader.setFloat(_setter.index + offset + 2, z);
  }

  /// Set the w sub-field of the associated vec4 uniform.
  @override
  set w(double w) {
    super.w = w;
    shader.setFloat(_setter.index + offset + 3, w);
  }

  /// The [FragmentShader] instance in which the associated vec4 is a uniform.
  final FragmentShader shader;
  /// The name of the associated vec4 uniform defined within the shader.
  final String name;
  /// An additional offset from the named uniform defined within the shader,
  /// useful for when the vec4 is in an array.
  final int offset;

  // The internal UniformFloatSlot used to access the floats of the vec4.
  final UniformFloatSlot _setter;
}
