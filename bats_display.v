`include "bat_data_generator.v"

module bats_display(
	input wire h4,
  	input wire h128,
  	input wire h256,
  	input wire hsync,
  	input wire left_start,
  	output wire display_on
);
  
  reg q;

  always @(posedge h4)
    q <= h128;
  
  wire bats_h_display = (h128 & ~q);
  
  /// LEFT BAT
  wire left_vbat;
  reg [2:0] left_bcd;
  bat_data_generator left_bat(
    .start(left_start),
    .hsync(hsync),
    .vbat(left_vbat),
    .bcd(left_bcd)
  );
  
  wire display_on = bats_h_display && (left_vbat);
  
endmodule