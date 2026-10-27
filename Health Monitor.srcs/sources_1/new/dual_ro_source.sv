`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 11:09:14 AM
// Design Name: 
// Module Name: dual_ro_source
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


module dual_ro_source #(
  parameter STAGE1 = 5,
  parameter STAGE2 = 7
)(
  input logic en1,
  input logic en2,
  output logic ro1,
  output logic ro2
);

  ring_osc #(.STAGES(STAGE1)) u_ro1 (.ro_out(ro1), .en(en1));
  ring_osc #(.STAGES(STAGE2)) u_ro2 (.ro_out(ro2), .en(en2));


endmodule
