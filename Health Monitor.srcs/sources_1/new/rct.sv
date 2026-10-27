`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 01:01:45 PM
// Design Name: 
// Module Name: rct
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


module rct #(
  parameter W = 16
)
(
  input  logic clk, rst,
  input  logic data_in,
  input  logic [W-1:0] cutoff_C,    
  output logic fail, 
       
  output logic [W-1:0] run_count // Debug
);
  logic [W-1:0] count;
  logic data_in_prev;
  logic first_sample_flag;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      count <= 1'b0;
      fail <= 1'b0;
      data_in_prev <= 1'b0;
      first_sample_flag <= 1'b1;
    end
    else begin
      if(first_sample_flag) begin
        first_sample_flag <= 1'b0;
        count <= 1'b1;
      end
      else if(data_in_prev == data_in) begin
        count <= count + 1;
      end
      else 
        count <= 1'b1;
      
      data_in_prev <= data_in;
      fail <= (count >= cutoff_C);
    end
  end
  
  assign run_count = count;
  
endmodule
