`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 11:05:46 AM
// Design Name: 
// Module Name: trng
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


module trng
( 
  input logic rst,
  input logic sel,
  
  output logic random_bit,
  output logic sample_clk,
  output [15:0] phase_diff
);

  logic ro1;
  logic ro2;
  logic div_o;
  logic [15:0] cout;
  logic [2:0] sel;
  

  dual_ro_source u_source (.ro1(ro1),.ro2(ro2));
  dual_ro_sampler u_sampler (.ro1(ro1),.ro2(div_o),.data_out(random_bit));
  ro_ripple_divider u_ro_ripple_divider 
  (
    .ro_clk (ro2),
    .rst    (rst),
    .sel    (sel),
    .div_o  (div_o)
  );
  phase_counter u_phase_counter (.ro1(ro1),.div_o(div_o),.rst(rst),.cout(cout));
  
  assign sample_clk = div_o;
  assign phase_diff = cout;

endmodule
