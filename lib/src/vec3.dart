// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:shader_uniforms/shader_uniforms.dart';

/// A 3 element vector class that mimics the field access behaviors of
/// a GPU vec3 variable.
///
/// Though there are only 3 fields, these fields can be accessed using
/// any of:
///
/// - x - the first element
/// - y - the second element
/// - z - the third element
///
/// - r - an alias for the first element
/// - g - an alias for the second element
/// - b - an alias for the third element
///
/// - s - an alias for the first element
/// - t - an alias for the second element
/// - p - an alias for the third element
///
/// - xy - an alias for the first 2 elements together expressed as an Offset
/// - st - an alias for the first 2 elements together expressed as an Offset
///
/// - [] - indexing the elements as if they were a list:
/// - [0] - the x element
/// - [1] - the y element
/// - [2] - the z element
class Vec3 {
  /// Instantiate a Vec3 object with optional data, otherwise fields are
  /// initialized to 0s.
  Vec3([double v0 = 0.0, double v1 = 0.0, double v2 = 0.0])
      : x = v0, y = v1, z = v2;

  factory Vec3.fromIndex(FragmentShader shader, int base) {
    return UniformVec3(shader: shader, base: base);
  }

  factory Vec3.fromName(FragmentShader shader, String name, [int offset = 0]) {
    return NamedUniformVec3(shader: shader, name: name, offset: offset);
  }

  /// Set the x sub-field of the vec3.
  double x;
  /// Set the y sub-field of the vec3.
  double y;
  /// Set the z sub-field of the vec3.
  double z;

  /// Set the s sub-field of the vec3 (aliased to [x]).
  set s(double s) => x = s;
  double get s => x;

  /// Set the t sub-field of the vec3 (aliased to [y]).
  set t(double t) => y = t;
  double get t => y;

  /// Set the p sub-field of the vec3 (aliased to [z]).
  set p(double p) => z = p;
  double get p => z;

  /// Set the r sub-field of the vec3 (aliased to [x]).
  set r(double r) => x = r;
  double get r => x;

  /// Set the g sub-field of the vec3 (aliased to [y]).
  set g(double g) => y = g;
  double get g => y;

  /// Set the b sub-field of the vec3 (aliased to [z]).
  set b(double b) => z = b;
  double get b => z;

  /// Set both the [x] and [y] sub-fields of the vec3.
  set xy(Offset o) { x = o.dx; y = o.dy; }
  Offset get xy => Offset(x, y);

  /// Set both the [s] and [t] sub-fields of the vec3 (aliased to [x] and [y]).
  set st(Offset o) => xy = o;
  Offset get st => xy;

  /// Set all 3 sub-fields of the vec3 to the 3 provided values.
  /// These values can represent any of (in order):
  /// - x, y, z
  /// - r, g, b
  /// - s, t, p
  void set(double v0, double v1, double v2) {
    x = v0;
    y = v1;
    z = v2;
  }

  /// Set all 3 [r], [g], and [b] sub-fields of the vec3
  /// to the associated color components of the [Color] object.
  ///
  /// When setting the vec3 from a color the alpha component of the color
  /// is ignored. When getting the color from a vec3, an opaque color is
  /// returned.
  set color(Color c) {
    set(c.r, c.g, c.b);
  }
  Color get color => Color.from(alpha: 1.0, red: r, green: g, blue: b);

  /// Set a sub-field of the vec3 by index.
  /// * index 0 sets the [x] or [s] sub-field.
  /// * index 1 sets the [y] or [t] sub-field.
  /// * index 2 sets the [z] or [p] sub-field.
  void operator []=(int index, double v) {
    switch (index) {
      case 0:
        x = v;
        break;
      case 1:
        y = v;
        break;
      case 2:
        z = v;
        break;
      default:
        throw RangeError('$index out of range');
    }
  }

  /// Get a sub-field of the vec3 by index.
  /// * index 0 gets the [x] or [s] sub-field.
  /// * index 1 gets the [y] or [t] sub-field.
  /// * index 2 gets the [z] or [p] sub-field.
  double operator[](int index) {
    switch (index) {
      case 0:
        return x;
      case 1:
        return y;
      case 2:
        return z;
      default:
        throw RangeError('$index out of range');
    }
  }
}
