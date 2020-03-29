`include "segments.v"

`ifndef SCORES_DISPLAY_H
`define SCORES_DISPLAY_H


module scores_display (
  input reg [3:0] counter_left,
  input reg [3:0] counter_right,
  input reg h2,
  input reg h4,
  input reg h8,
  input reg h16,
  input reg h32,
  input reg h64,
  input reg h128,
  input reg h256,
  input reg v2,
  input reg v4,
  input reg v8,
  input reg v16,
  input reg v32,
  input reg v64,
  input reg v128,
  input reg v256,
  output wire score_display
  );
  
  // Score windows 
  
  wire left_window_h, right_window_h;
  wire window_v;
  
  wire left_window_active = left_window_h && window_v;
  wire right_window_active = right_window_h && window_v;
  
  assign left_window_h = (h256 == 1) && (h128 == 0) && (h64 == 1);
  assign right_window_h = (h256 == 0) && (h128 == 1) && (h64 == 0);
  assign window_v = (v256 == 1) && (v128 == 1) && (v64 == 1);
  
  // Segments activation
  // Left low score
  reg [3:0] left_low = 9;
  wire ll_a, ll_b, ll_c, ll_d,ll_e, ll_f, ll_g;
  segments seg(.value(left_low),
               .a(ll_a),
               .b(ll_b),
               .c(ll_c),
               .d(ll_d),
               .e(ll_e),
               .f(ll_f),
               .g(ll_g)
              );
  wire ll_a_display, ll_b_display, ll_c_display, ll_d_display,ll_e_display, ll_f_display, ll_g_display;
  assign ll_a_display = ll_a && (h16 && ~v16 && ~v8 && ~v4);  
  assign ll_b_display = ll_b && (h16 && ~v16 && h8 && h4); 
  assign ll_c_display = ll_c && (h16 && v16 && h8 && h4); 
  assign ll_d_display = ll_d && (h16 && ~v16 && v8 && v4);
  assign ll_e_display = ll_e && (h16 && v16 && ~h8 && ~h4);
  assign ll_f_display = ll_a && (h16 && ~v16 && ~h8 && ~h4); 
  assign ll_g_display = ll_a && (h16 && ~v16 && v8 && v4);
  
  wire ll_segments_display;
  assign ll_segments_display = (ll_a_display || ll_b_display || ll_c_display || ll_d_display || ll_e_display || ll_f_display|| ll_g_display);
  
  wire ll_score_display = left_window_active && ( ll_segments_display );
    
  
  // Right score
  
  // Score display
  
  assign score_display = ll_score_display || right_window_active;

endmodule

`endif

