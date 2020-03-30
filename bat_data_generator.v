`ifndef BAT_DATA_GENERATOR_H
`define BAT_DATA_GENERATOR_H

module bat_data_generator(
  input wire start,
  input wire hsync,
  output wire vbat,
  output reg[2:0] bcd
);
  
  reg [3:0] counter = 0;
  
  reg q;
  always @(posedge hsync)
    q <= start;
  wire start_trigger = (start & ~q);
  
  always @(posedge hsync or posedge start) begin
    if (start_trigger) begin
      counter <= 0;
      vbat <= 1;
    end
    else if (vbat) begin
      counter <= counter + 1;
      if (counter == 15) vbat <= 0;
    end
  end
      
  assign bcd = counter[3:1];
  
endmodule

`endif