`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:43:36 PM
// Design Name: 
// Module Name: trng_test
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


module trng_test
(
  input  logic       ro1,       // đưa ra ngoài để testbench tự cấp
  input  logic       ro2,       // đưa ra ngoài để testbench tự cấp
  input  logic       rst,       // (module gốc thiếu khai báo này)
  input  logic [4:0] sel,       // (module gốc thiếu khai báo này)
  output logic        random_bit,
  output logic [15:0] phase_diff,
  output logic         div_o      // đưa ra để testbench quan sát/kiểm tra chu kỳ chia
);

  // KHÔNG instantiate dual_ro_source ở đây nữa -
  // ro1, ro2 đến thẳng từ testbench, không qua mạch RO thật.

  dual_ro_sampler u_sampler (
    .ro1(ro1), .ro2(div_o), .data_out(random_bit)
  );

  ro_ripple_divider u_ro_ripple_divider (
    .ro_clk(ro2), .rst(rst), .sel(sel), .div_o(div_o)
  );

  phase_counter u_phase_counter (
    .ro1(ro1), .div_o(div_o), .rst(rst), .cout(phase_diff)
  );

endmodule
