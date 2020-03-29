`include "clocks.v"
`include "hvsync_generator.v"
`include "net.v"
`include "scores_display.v"
`include "segments.v"

module pong(clk, reset, hsync, vsync, rgb);

  input clk, reset;
  output hsync, vsync;
  output [2:0] rgb;
  
  // Display
  reg hblank, vblank;
  
  // Pong has 262 vertical clocks
  // Simulateur shows 240 vertical lines
  reg v2, v4, v8, v16, v32, v64, v128, v256;
  // Pong has 455 horizontal clocks
  // Simulateur shows 256 horizontal lines
  reg h2, h4, h8, h16, h32, h64, h128, h256, h512;

  /// SCREEN GENERATOR
  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .hblank(hblank),
    .vblank(vblank)
  );
  
  /// VERTICAL CLOCKS
  clocks v_clock(
    .clk(hsync),
    .reset(vblank),
    .clk_div2(v2),
    .clk_div4(v4),
    .clk_div8(v8),
    .clk_div16(v16),
    .clk_div32(v32),
    .clk_div64(v64),
    .clk_div128(v128),
    .clk_div256(v256)
  );
  
  /// HORIZONTAL CLOCKS
  clocks h_clock(
    .clk(clk),
    .reset(hblank),
    .clk_div2(h2),
    .clk_div4(h4),
    .clk_div8(h8),
    .clk_div16(h16),
    .clk_div32(h32),
    .clk_div64(h64),
    .clk_div128(h128),
    .clk_div256(h256)
  );
  
  /// NET DISPLAY
  wire net_on;
  net net_dis(
    .h(clk),
    .h256(h256),
    .v4(v4),
    .net_display(net_on)
  );
  
  /// SCORE DISPLAY
  wire score_on;
  reg [3:0] left_score_counter = 0;
  reg [3:0] right_score_counter = 0;
  scores_display score_dis(
    .counter_right(right_score_counter),
    .counter_left(left_score_counter),
    .h2(h2),
    .h4(h4),
    .h8(h8),
    .h16(h16),
    .h32(h32),
    .h64(h64),
    .h128(h128),
    .h256(h256),
    .v2(v2),
    .v4(v4),
    .v8(v8),
    .v16(v16),
    .v32(v32),
    .v64(v64),
    .v128(v128),
    .v256(v256),
    .score_display(score_on)
  );
  
  /// AGREGATE DISPLAYS
  
  wire display_on = ~(hblank || vblank);
  
  wire r = display_on && (net_on || score_on);
  wire g = display_on && net_on;
  wire b = display_on && net_on;
  assign rgb = {b,g,r};

endmodule

