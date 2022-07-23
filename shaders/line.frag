precision mediump float;

{{triadica_colors}}

varying float v_r;
varying float v_s;
varying vec3 original_position;

void main() {
  gl_FragColor = vec4(hsl2rgb(0.1, 0.9, 0.5), 1.0);
}
