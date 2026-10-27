`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2026 02:00:07 PM
// Design Name: 
// Module Name: phase_counter
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


module phase_counter(
  input  logic rst,
  input  logic ro1,
  input  logic div_o,
  
  output logic [15:0] cout
    );
  
  localparam CNT_WIDTH = 16;
  function automatic logic [CNT_WIDTH-1:0] gray2bin(input logic [CNT_WIDTH-1:0] g);
    logic [CNT_WIDTH-1:0] b;
    integer k;
    begin
      b[CNT_WIDTH-1] = g[CNT_WIDTH-1];
      for (k = CNT_WIDTH-2; k >= 0; k = k - 1)
        b[k] = b[k+1] ^ g[k];
      gray2bin = b;
    end
  endfunction
    
  logic [15:0] cnt;
  logic [15:0] gray, gray_reg1, gray_reg2, gray_reg3;
  
  
  always @(posedge ro1 or posedge rst) begin
  if(rst) begin
    cnt <= 0;
    gray <= 0;
  end
  else begin
    cnt <= cnt + 1;
    gray <= (cnt+1) ^ ((cnt+1) >> 1);
  end
  end
  
  always @(posedge div_o) begin
    gray_reg1 <= gray;
    gray_reg2 <= gray_reg1;
    gray_reg3 <= gray_reg2;
    cout <= gray2bin(gray_reg2) - gray2bin(gray_reg3);
  end
        
endmodule
