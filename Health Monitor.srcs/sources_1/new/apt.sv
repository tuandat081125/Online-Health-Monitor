`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2026 09:58:28 AM
// Design Name: 
// Module Name: apt
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


module apt #(
  parameter W = 16
)
(
  input  logic clk, rst,
  input  logic data_in,
  input  logic [W-1:0] window_size,
  input  logic [W-1:0] cutoff_C,    
  output logic fail, 
       
  output logic [W-1:0] run_count // Debug
);

  logic [W-1:0] window_count;
  logic [W-1:0] window_size_reg;
  logic [W-1:0] count0, count1;
  logic window_rst;

  always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
      window_count <= 1'b0;
      window_size_reg <= window_size;
      count0 <= 1'b0;
      count1 <= 1'b0;
    end
    else if(window_rst) begin
      window_count <= 1'b1;
      window_size_reg <= window_size;
      if(data_in == 0) begin
        count0 <= 1'b1;
        count1 <= 1'b0;
      end
      else begin
        count0 <= 1'b0;
        count1 <= 1'b1;
      end
      
      fail <= (count0 >= cutoff_C) || (count1 >= cutoff_C); 
    end
    else begin
      if(data_in == 0)
        count0 <= count0 + 1;
      else
        count1 <= count1 + 1;
        
      window_count <= window_count + 1;
      fail <= (count0 >= cutoff_C) || (count1 >= cutoff_C);
    end
  end
  
  assign window_rst = (window_count == window_size_reg);
  
  assign run_count = count0;
  
endmodule
