`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2026 04:57:33 PM
// Design Name: 
// Module Name: tb_rct
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


module tb_rct;
  logic rst, div_o;
  logic [15:0] fail_count;
  logic rct_fail;
  logic [15:0] cutoff_C;
  
  bit  hist[$];               // hist lưu mọi bit đã được DUT lấy mẫu
  int  errors = 0;
  bit  saw_fail = 0;
  
  int histsize;
  int runcheck_debug;
  
  logic exp_fail;
  
  logic random_bit_script;
  
  always 
    #5 div_o = rst ? 0 : (~div_o);
  
  function automatic int runcheck(input int m);
    int r;
    if (m <= 0) return 0;
    r = 1;
    for (int i = m-2; i >= 1; i--) //Delay 1 chu ky 
      begin
        if (hist[i] == hist[i-1]) r++;
        else break;
      end
    return r;
  endfunction
  
  task automatic drive(input bit b, input int n);
    repeat (n) begin @(posedge div_o); 
      random_bit_script <= b; 
    end
  endtask
  
  always @(negedge div_o) begin
    hist.push_back(random_bit_script);
    histsize = hist.size();
    runcheck_debug = runcheck(hist.size());
    
    if(rct_fail != exp_fail) begin
        errors ++;
      end
  end
  
  always @(posedge div_o) begin  
    if(hist.size() > 0 && rst != 1) begin
      exp_fail = (runcheck(hist.size()) >= cutoff_C);
      $display("R: t=%t, r=%d", $time, runcheck(hist.size()));
    end 
  end

  rct #(.W(16)) u_rct (
    .clk      (div_o),
    .rst      (rst),
    .data_in  (random_bit_script),
    .cutoff_C (cutoff_C),
    .fail     (rct_fail),
    .run_count(fail_count)
  );

  initial begin
    $display("========== TB START ==========");
    div_o = 1'b0;
    cutoff_C = 16'd010;
    rst = 1'b1;
    #98 rst = 1'b0;
    
    //Scrpt 1
    $display("========== SCRIPT 1  ==========");
    repeat (5) begin
      drive(0, cutoff_C - 1);
      drive(1, cutoff_C - 1);
    end
    
    //Scrpt 2
    $display("========== SCRIPT 2 ==========");
    repeat (5) begin
      drive(0, cutoff_C);
      drive(1, cutoff_C);
    end
    
    //Scrpt 3
      
  end

endmodule
