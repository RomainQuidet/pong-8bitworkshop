`ifndef NET_H
`define NET_H

/*
Net: module used to display net in the middle of the screen

*/
module net (
    input reg h,
    input reg h256, 
    input reg v4,
    output wire net_display
  );
  
  reg net_on;
  reg net_armed;
  
  always @(posedge h) begin
    if (h256 == 0) net_armed <= 1;
    else begin
      if (net_armed == 1) begin
        net_armed <= 0;
        net_on <= 1;
      end
      else net_on <=0;
    end
  end
  
  assign net_display = net_on & v4;
      
endmodule

`endif 

