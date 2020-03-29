`ifndef SEGMENTS_H
`define SEGMENTS_H

module segments(
  input reg [3:0] value,
  output reg a,
  output reg b,
  output reg c,
  output reg d,
  output reg e,
  output reg f,
  output reg g
);
  
  always @(value) begin
    case(value)
      0: begin a=1; b=1; c=1; d=1; e=1; f=1; g=0; end
      1: begin a=0; b=1; c=1; d=0; e=0; f=0; g=0; end
      2: begin a=1; b=1; c=0; d=1; e=1; f=0; g=1; end
      3: begin a=1; b=1; c=1; d=0; e=0; f=0; g=1; end
      4: begin a=0; b=1; c=1; d=0; e=0; f=1; g=1; end
      5: begin a=1; b=0; c=1; d=1; e=0; f=1; g=1; end
      6: begin a=1; b=0; c=1; d=1; e=1; f=1; g=1; end
      7: begin a=1; b=1; c=1; d=0; e=0; f=0; g=0; end
      4: begin a=1; b=1; c=1; d=1; e=1; f=1; g=1; end
    endcase
  end
  
endmodule

`endif