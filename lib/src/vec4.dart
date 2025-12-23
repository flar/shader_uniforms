// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:shader_uniforms/shader_uniforms.dart';

/// A 4 element vector class that mimics the field access behaviors of
/// a GPU vec4 variable.
///
/// Though there are only 4 fields, these fields can be accessed using
/// any of:
///
/// - x - the first element
/// - y - the second element
/// - z - the third element
/// - w - the fourth element
///
/// - s - an alias for the first element
/// - t - an alias for the second element
/// - p - an alias for the third element
/// - q - an alias for the fourth element
///
/// - xy - an alias for the first 2 elements together expressed as an Offset
/// - zw - an alias for the last 2 elements together expressed as an Offset
/// - st - an alias for the first 2 elements together expressed as an Offset
/// - pq - an alias for the last 2 elements together expressed as an Offset
///
/// - xyzw - an alias for all 4 elements together expressed as a Vec4
/// - rgba - an alias for all 4 elements together expressed as a Vec4
/// - stpq - an alias for all 4 elements together expressed as a Vec4
///
/// - [] - indexing the elements as if they were a list:
/// - [0] - the x element
/// - [1] - the y element
/// - [2] - the z element
/// - [3] - the w element
class Vec4 {
  /// Instantiate a Vec3 object with optional data, otherwise fields are
  /// initialized to 0s.
  Vec4([double v0 = 0.0, double v1 = 0.0, double v2 = 0.0, double v3 = 0.0])
      : x = v0, y = v1, z = v2, w = v3;

  factory Vec4.fromIndex(FragmentShader shader, int base) {
    return UniformVec4(shader: shader, base: base);
  }

  factory Vec4.fromName(FragmentShader shader, String name, [int offset = 0]) {
    return NamedUniformVec4(shader: shader, name: name, offset: offset);
  }

  /// Set the x sub-field of the vec4.
  double x;
  /// Set the y sub-field of the vec4.
  double y;
  /// Set the z sub-field of the vec4.
  double z;
  /// Set the w sub-field of the vec4.
  double w;

  /// Set the s sub-field of the vec4 (aliased to [x]).
  set s(double s) => x = s;
  double get s => x;
  /// Set the t sub-field of the vec4 (aliased to [y]).
  set t(double t) => y = t;
  double get t => y;
  /// Set the p sub-field of the vec4 (aliased to [z]).
  set p(double p) => z = p;
  double get p => z;
  /// Set the q sub-field of the vec4 (aliased to [w]).
  set q(double q) => w = q;
  double get q => w;

  /// Set the r sub-field of the vec4 (aliased to [x]).
  set r(double r) => x = r;
  double get r => x;
  /// Set the g sub-field of the vec4 (aliased to [y]).
  set g(double g) => y = g;
  double get g => y;
  /// Set the b sub-field of the vec4 (aliased to [z]).
  set b(double b) => z = b;
  double get b => z;
  /// Set the a sub-field of the vec4 (aliased to [w]).
  set a(double a) => w = a;
  double get a => w;

  /// Set both the [x] and [y] sub-fields of the vec4.
  set xy(Offset o) { x = o.dx; y = o.dy; }
  Offset get xy => Offset(x, y);
  /// Set both the [z] and [w] sub-fields of the vec4.
  set zw(Offset o) { z = o.dx; w = o.dy; }
  Offset get zw => Offset(z, w);
  /// Set both the [s] and [t] sub-fields of the vec4 (aliased to [x] and [y]).
  set st(Offset o) => xy = o;
  Offset get st => xy;
  /// Set both the [p] and [q] sub-fields of the vec4 (aliased to [z] and [w]).
  set pq(Offset o) => zw = o;
  Offset get pq => zw;

  /// Set all 4 of the [x], [y], [z] and [w] sub-fields of the vec4.
  set xyzw(Vec4 v) => set(v.x, v.y, v.z, v.w);
  Vec4 get xyzw => Vec4(x, y, z, w);

  /// Set all 4 of the [s], [t], [p] and [q] sub-fields of the vec4
  /// (aliased to [x], [y], [z] and [w]).
  set stpq(Vec4 v) => xyzw = v;
  Vec4 get stpq => xyzw;

  /// Set all 4 of the [r], [g], [b] and [a] sub-fields of the vec4
  /// (aliased to [x], [y], [z] and [w]).
  set rgba(Vec4 v) => xyzw = v;
  Vec4 get rgba => xyzw;

  /// Set all 4 [r], [g], [b], and [a] sub-fields of the vec4
  /// to the associated color and alpha components of the [Color] object.
  set color(Color c) {
    set(c.r, c.g, c.b, c.a);
  }
  Color get color => Color.from(alpha: a, red: r, green: g, blue: b);

  /// Set all 4 sub-fields of the vec4 to the 4 provided values.
  /// These values can represent any of (in order):
  /// - x, y, z, w
  /// - r, g, b, a
  /// - s, t, p, q
  void set(double v0, double v1, double v2, double v3) {
    x = v0;
    y = v1;
    z = v2;
    w = v3;
  }

  /// Set a sub-field of the vec4 by index.
  /// * index 0 sets the [x] or [s] or [r] sub-field.
  /// * index 1 sets the [y] or [t] or [g] sub-field.
  /// * index 2 sets the [z] or [p] or [b] sub-field.
  /// * index 3 sets the [w] or [q] or [a] sub-field.
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
      case 3:
        w = v;
        break;
      default:
        throw RangeError('$index out of range');
    }
  }

  /// Get a sub-field of the vec4 by index.
  /// * index 0 gets the [x] or [s] or [r] sub-field.
  /// * index 1 gets the [y] or [t] or [g] sub-field.
  /// * index 2 gets the [z] or [p] or [b] sub-field.
  /// * index 3 gets the [w] or [q] or [a] sub-field.
  double operator[](int index) {
    switch (index) {
      case 0:
        return x;
      case 1:
        return y;
      case 2:
        return z;
      case 3:
        return w;
      default:
        throw RangeError('$index out of range');
    }
  }
}
