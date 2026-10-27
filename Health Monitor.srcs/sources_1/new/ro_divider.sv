`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2026 09:14:02 PM
// Design Name: 
// Module Name: ro_divider
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


module ro_ripple_divider #(
  parameter integer LEVELS = 7,
  parameter integer SEL_WIDTH = $clog2(LEVELS)
)(
  input wire ro_clk,
  input wire rst,
  input logic [SEL_WIDTH-1:0] sel,
  output wire div_o
);

  wire [LEVELS-1:0] div;
 
  genvar i;
  generate
      for (i = 0; i < LEVELS; i = i + 1) begin : GEN_DIV
        if (i == 0) begin : GEN_FIRST
        (* DONT_TOUCH = "TRUE" *)
           FDCE u_ff (.C   (ro_clk),
                      .CE  (1'b1),
                      .CLR (rst),
                      .D   (~div[0]),
                      .Q   (div[0]));
        end
          else begin : GEN_NEXT
          (* DONT_TOUCH = "TRUE" *)
            FDCE u_ff (.C   (div[i-1]),
                       .CE  (1'b1),
                       .CLR (rst),
                       .D   (~div[i]),
                       .Q   (div[i]));
          end
        end
    endgenerate
    
  assign div_o = div[sel];

endmodule
