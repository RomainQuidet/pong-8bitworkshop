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
  
  assign left_window_h = ~h256 && h128 && ~h64;
  assign right_window_h = h256 && ~h128 && h64;
  assign window_v = ~v256 && ~v128 && ~v64 && v32;
  
  //// Segments activation
  
  wire a_display = (h16 && ~v16 && ~v8 && ~v4);  
  wire b_display = (h16 && ~v16 && h8 && h4); 
  wire c_display = (h16 && v16 && h8 && h4); 
  wire d_display = (h16 && v16 && v8 && v4);
  wire e_display = (h16 && v16 && ~h8 && ~h4);
  wire f_display = (h16 && ~v16 && ~h8 && ~h4); 
  wire g_display = (h16 && ~v16 && v8 && v4);
  
  // Left low score
  reg [3:0] left_low = (counter_left >= 10) ? counter_left - 10 : counter_left;
  wire ll_a, ll_b, ll_c, ll_d, ll_e, ll_f, ll_g;
  segments seg_ll(.value(left_low),
               .a(ll_a),
               .b(ll_b),
               .c(ll_c),
               .d(ll_d),
               .e(ll_e),
               .f(ll_f),
               .g(ll_g)
              );
  wire ll_a_display = ll_a && a_display;  
  wire ll_b_display = ll_b && b_display; 
  wire ll_c_display = ll_c && c_display; 
  wire ll_d_display = ll_d && d_display;
  wire ll_e_display = ll_e && e_display;
  wire ll_f_display = ll_f && f_display; 
  wire ll_g_display = ll_g && g_display;
  
  wire ll_segments_display = ll_a_display || ll_b_display || ll_c_display 
  				|| ll_d_display || ll_e_display || ll_f_display
  				|| ll_g_display;
  
  wire low_left_window_active = left_window_active && h32;
  wire ll_score_display = low_left_window_active && ll_segments_display;
  
  // Left high score
  reg [3:0] left_high = (counter_left >= 10) ? 1 : 0;
  wire should_show_left_high = (counter_left >= 10);
  wire lh_a, lh_b, lh_c, lh_d, lh_e, lh_f, lh_g;
  segments seg_lh(.value(left_high),
                  .a(lh_a),
                  .b(lh_b),
                  .c(lh_c),
                  .d(lh_d),
                  .e(lh_e),
                  .f(lh_f),
                  .g(lh_g)
              );
  wire lh_a_display = lh_a && a_display;  
  wire lh_b_display = lh_b && b_display; 
  wire lh_c_display = lh_c && c_display; 
  wire lh_d_display = lh_d && d_display;
  wire lh_e_display = lh_e && e_display;
  wire lh_f_display = lh_f && f_display; 
  wire lh_g_display = lh_g && g_display;
  
  wire lh_segments_display = lh_a_display || lh_b_display || lh_c_display 
  				|| lh_d_display || lh_e_display || lh_f_display
  				|| lh_g_display;
  
  wire left_high_window_active = left_window_active && ~h32;
  wire lh_score_display = should_show_left_high &&
  				left_high_window_active && lh_segments_display;
    
  
  // Right low score
  reg [3:0] right_low = (counter_right >= 10) ? counter_right - 10 : counter_right;
  wire rl_a, rl_b, rl_c, rl_d, rl_e, rl_f, rl_g;
  segments seg_rl(.value(right_low),
                  .a(rl_a),
                  .b(rl_b),
                  .c(rl_c),
                  .d(rl_d),
                  .e(rl_e),
                  .f(rl_f),
                  .g(rl_g)
              );
  wire rl_a_display = rl_a && a_display;  
  wire rl_b_display = rl_b && b_display; 
  wire rl_c_display = rl_c && c_display; 
  wire rl_d_display = rl_d && d_display;
  wire rl_e_display = rl_e && e_display;
  wire rl_f_display = rl_f && f_display; 
  wire rl_g_display = rl_g && g_display;
  
  wire rl_segments_display = rl_a_display || rl_b_display || rl_c_display 
  				|| rl_d_display || rl_e_display || rl_f_display
  				|| rl_g_display;
  
  wire right_low_window_active = right_window_active && h32;
  wire rl_score_display = right_low_window_active && rl_segments_display;
  
  // Right high score
  reg [3:0] right_high = (counter_right >= 10) ? 1 : 0;
  wire should_show_right_high = (counter_right >= 10);
  wire rh_a, rh_b, rh_c, rh_d, rh_e, rh_f, rh_g;
  segments seg_rh(.value(right_high),
                  .a(rh_a),
                  .b(rh_b),
                  .c(rh_c),
                  .d(rh_d),
                  .e(rh_e),
                  .f(rh_f),
                  .g(rh_g)
              );
  wire rh_a_display = rh_a && a_display;  
  wire rh_b_display = rh_b && b_display; 
  wire rh_c_display = rh_c && c_display; 
  wire rh_d_display = rh_d && d_display;
  wire rh_e_display = rh_e && e_display;
  wire rh_f_display = rh_f && f_display; 
  wire rh_g_display = rh_g && g_display;
  
  wire rh_segments_display = rh_a_display || rh_b_display || rh_c_display 
  				|| rh_d_display || rh_e_display || rh_f_display
  				|| rh_g_display;
  
  wire right_high_window_active = right_window_active && ~h32;
  wire rh_score_display = should_show_right_high &&
  				right_high_window_active && rh_segments_display;
  
  // Score display
  
  assign score_display = ll_score_display || lh_score_display 
    				|| rl_score_display || rh_score_display;

endmodule

`endif

