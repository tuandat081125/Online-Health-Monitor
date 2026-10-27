`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 10:46:35 AM
// Design Name: 
// Module Name: dual_ro_sampler
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


module dual_ro_sampler
(
  input  logic ro1,
  input  logic ro2,

  output logic data_out
);

  always_ff @(posedge ro2)  begin
    data_out <= ro1;
  end

  
endmodule
