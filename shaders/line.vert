
{{triadica_perspective}}
{{triadica_noises}}

attribute vec3 a_position;

varying float v_r;
varying float v_s;
varying float z_color;
varying vec3 original_position;

void main() {

  PointResult result = transform_perspective(a_position);
  vec3 pos_next = result.point;

  // original_position = a_position;

  v_r = result.r;
  v_s = result.s;

  gl_Position = vec4(pos_next * 0.001, 1.0);
}