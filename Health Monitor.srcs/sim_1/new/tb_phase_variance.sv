`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2026 10:11:14 AM
// Design Name: 
// Module Name: tb_phase_variance
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


module tb_phase_variance;

  parameter int WINDOW_SIZE = 128;
  parameter int SUM_WIDTH   = 40;
  parameter int N_WIDTH     = 24;
  
  localparam WINDOW_SHIFT = $clog2(WINDOW_SIZE);

  logic                      div_o, rst;
  logic signed [N_WIDTH-1:0] n_in;
  logic [SUM_WIDTH-1:0]      var_threshold;
  logic                      fail;
  logic [SUM_WIDTH-1:0]      var_debug;
  
  logic [WINDOW_SHIFT-1:0] window_count;
   
  
  always 
    #5 div_o = rst ? 0 : (~div_o);

  phase_variance #(
    .WINDOW_SIZE (WINDOW_SIZE),
    .SUM_WIDTH   (SUM_WIDTH),
    .N_WIDTH     (N_WIDTH)
  ) u_phase_variance (
    .clk           (div_o),
    .rst           (rst),
    .n_in          (n_in),
    .var_threshold (var_threshold),
    .fail          (fail),
    .var_debug     (var_debug)
  );
  
  always @(posedge div_o)
    if(rst)
      window_count <= 0;
    else begin
      window_count <= window_count + 1;
      sum =
      sumsq =
    end
    
  initial begin
    div_o = 1'b0;
    var_threshold = 40'd150;
    rst = 1'b1;
    #98 rst = 1'b0;
  end
  
endmodule
