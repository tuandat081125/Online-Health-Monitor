`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2026 07:01:12 PM
// Design Name: 
// Module Name: ring_osc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ring_osc #(
  parameter STAGES = 5
)(
  input logic en,
  output wire ro_out
);

  (* KEEP = "TRUE" *)
  (* DONT_TOUCH = "TRUE" *)
  wire [STAGES-1:0] ro;
  
  genvar i;
  generate
  LUT2 #(.INIT(4'b0111)) lut0(.I0(ro[STAGES-1]), .I1(en), .O(ro[0]));
  
  for(i=1; i<STAGES; i=i+1)
    begin
      LUT1 #(.INIT(2'b01)) lut(.I0(ro[i-1]), .O(ro[i]));
    end
  endgenerate
  
  assign ro_out = ro[STAGES-1];
endmodule

