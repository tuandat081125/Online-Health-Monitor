`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 12:44:30 PM
// Design Name: 
// Module Name: ro_gen_sim
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


// ============================================================================
// ro_gen_sim.sv - MO HINH HANH VI cua mot dao dong vong, dung cho TESTBENCH.
//   Nua chu ky = HALF_PS + jitter Gauss doc lap moi nua chu ky.
//   KHONG tong hop duoc (dung $dist_normal, delay thuc).
// ============================================================================
`timescale 1ps/1fs

module ro_gen_sim #(
    parameter real    HALF_PS  = 2000.0,  // nua chu ky trung binh [ps]
    parameter real    SIGMA_PS = 5.0,     // do lech chuan jitter moi nua chu ky [ps]
    parameter integer SEED     = 1
)(
    input  logic en,
    output logic out
);
    integer seed;
    integer g;
    real    d;

    initial begin
        seed = SEED;
        out  = 1'b1;
    end

    always begin
        wait (en);
        g = $dist_normal(seed, 0, 1000);           // N(0,1000) -> chia 1000 de duoc N(0,1)
        d = HALF_PS + SIGMA_PS * g / 1000.0;
        if (d < 100.0) d = 100.0;                    // chan an toan, tranh delay am/qua nho
        #(d);
        out = ~out;
    end
endmodule
