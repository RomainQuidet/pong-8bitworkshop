
/*
A clock divider in Verilog, using the cascading
flip-flop method.
*/

module clocks(
  input clk,
  input reset,
  output reg clk_div2,
  output reg clk_div4,
  output reg clk_div8,
  output reg clk_div16,
  output reg clk_div32,
  output reg clk_div64,
  output reg clk_div128,
  output reg clk_div256
);

  // simple ripple clock divider
  
  always @(negedge clk or posedge reset) begin
    if (reset) clk_div2 <= 0;
    else clk_div2 <= ~clk_div2;
  end

  always @(negedge clk_div2 or posedge reset) begin
    if (reset) clk_div4 <= 0;
    else clk_div4 <= ~clk_div4;
  end

  always @(negedge clk_div4 or posedge reset) begin
    if (reset) clk_div8 <= 0;
    else clk_div8 <= ~clk_div8;
  end

  always @(negedge clk_div8 or posedge reset) begin
    if (reset) clk_div16 <= 0;
    else clk_div16 <= ~clk_div16;
  end
  
  always @(negedge clk_div16 or posedge reset) begin
    if (reset) clk_div32 <= 0;
    else clk_div32 <= ~clk_div32;
  end

  always @(negedge clk_div32 or posedge reset) begin
    if (reset) clk_div64 <= 0;
    else clk_div64 <= ~clk_div64;
  end

  always @(negedge clk_div64 or posedge reset) begin
    if (reset) clk_div128 <= 0;
    else clk_div128 <= ~clk_div128;
  end

  always @(negedge clk_div128 or posedge reset) begin
    if (reset) clk_div256 <= 0;
    else clk_div256 <= ~clk_div256;
  end

endmodule

