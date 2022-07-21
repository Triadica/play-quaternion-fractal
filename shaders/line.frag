precision mediump float;

varying float v_r;
varying float v_s;
varying vec3 original_position;

void main() {
  float l = 0.6;
  gl_FragColor = vec4(l, l, l, 1.0);
}
