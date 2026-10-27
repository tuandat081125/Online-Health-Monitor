`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2026 07:22:21 PM
// Design Name: 
// Module Name: tb_trng
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:45:29 PM
// Design Name: 
// Module Name: trng_tb
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


module tb_trng;

  logic ro1, ro2, rst, div_o, random_bit;
  logic [2:0]  sel;
  logic [15:0] phase_diff;

  // Hai RO doc lap, khac tan so, khac seed - dung cho truong hop chung
  ro_gen_sim #(.HALF_PS(2000.0), .SIGMA_PS(5.0), .SEED(11)) u_ro1_gen (.en(1'b1), .out(ro1));
  ro_gen_sim #(.HALF_PS(2937.3), .SIGMA_PS(5.0), .SEED(23)) u_ro2_gen (.en(1'b1), .out(ro2));

  trng_test dut (
    .ro1(ro1), .ro2(ro2), .rst(rst), .sel(sel),
    .random_bit(random_bit), .phase_diff(phase_diff), .div_o(div_o)
  );

  initial begin
    sel = 3'b010;
    rst = 1'b1;
    #100 rst = 1'b0;
  end

endmodule
