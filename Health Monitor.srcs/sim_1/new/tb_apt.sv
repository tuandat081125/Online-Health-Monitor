`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2026 04:57:56 PM
// Design Name: 
// Module Name: tb_apt
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


module tb_apt;
  logic rst, div_o, random_bit_script;
  logic [15:0] cutoff_C;
  logic [15:0] window_size;
  logic        apt_fail;
  logic [15:0] apt_run_count;
  
  bit  hist[$];               // hist lưu mọi bit đã được DUT lấy mẫu
  int  errors = 0;
  bit  saw_fail = 0;
  
  logic exp_fail;
  
  int histsize;
  int runcheck_debug;
  
  int window_count;
  logic window_check;
  
  logic [15:0] window_count0;
  
  always 
    #5 div_o = rst ? 0 : (~div_o);
    
  function automatic int runcheck0(input int m);
    int r;
    if (m <= 0) return 0;
    r = 1;
    for (int i = m-1; i >= 0 ; i--)
      begin
        if (hist[i] == 0) r++;
      end
    return r;
  endfunction
  
  task automatic drive_fixed_random(input int n_zeros, input int n_ones);
    bit seq[];
    int total = n_zeros + n_ones;
    int idx;

    seq = new[total];

    //0-1 Fill
    for (int i = 0; i < n_zeros; i++) seq[i] = 1'b0;
    for (int i = n_zeros; i < total; i++) seq[i] = 1'b1;
 
    // Fisher-Yates shuffle
    for (int i = total - 1; i > 0; i--) begin
      idx = $urandom_range(0, i);
      begin
        bit tmp = seq[i];
        seq[i]  = seq[idx];
        seq[idx] = tmp;
      end
    end

    foreach (seq[i]) begin
      @(posedge div_o);
      random_bit_script <= seq[i];
    end
  endtask
  
  always @(negedge div_o) begin
    if(rst) begin
      window_check <= 0;
    end
    else if(hist.size() == window_size) begin
      window_check <= 1;
      window_count0 <= runcheck0(window_size);
      hist.delete();
    end
    
    hist.push_back(random_bit_script);
    
    if(apt_fail != exp_fail) begin
        errors ++;
      end
  end
  
  always @(posedge div_o) begin
    if(window_check) begin
      window_check <= 0;
      exp_fail = (window_count0 >= cutoff_C) || ((window_size - window_count0) >= cutoff_C);
    end 
  end
  
  apt #(.W(16)) u_apt (
  .clk         (div_o),
  .rst         (rst),
  .data_in     (random_bit_script),
  .window_size (window_size),
  .cutoff_C    (cutoff_C),
  .fail        (apt_fail),
  .run_count   (apt_run_count));

  initial begin
    $display("========== TB START ==========");
    div_o = 1'b0;
    cutoff_C = 16'd010;
    rst = 1'b1;
    #98 rst = 1'b0;
    
    //Scrpt 1
    $display("========== SCRIPT 1  ==========");
    drive_fixed_random(cutoff_C-1,(window_size-(cutoff_C-1)));
    
    //Scrpt 2
    $display("========== SCRIPT 2 ==========");
    drive_fixed_random(cutoff_C,(window_size-cutoff_C));
    
    //Scrpt 3
    
  end

endmodule
