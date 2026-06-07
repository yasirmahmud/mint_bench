`timescale 1ns/1ps

module test_cross_2;
  logic clk;
  logic [2:0] addr;
  logic [1:0] data;

  covergroup cg @(posedge clk);
    cp_addr: coverpoint addr;
    cp_data: coverpoint data;
    cross cp_addr, cp_data;
  endgroup

  cg c_inst;

  // Lint fix for W528: Variables 'addr' and 'data' are sampled by the covergroup,
  // but linters sometimes don't recognize this as a "read".
  // This block provides an explicit read to satisfy the linter without
  // affecting functional behavior or synthesis results (variables are optimized out).
  always @(posedge clk) begin
    logic [2:0] _lint_dummy_addr_read = addr;
    logic [1:0] _lint_dummy_data_read = data;
  end

`ifndef SYNTHESIS // Fix for SYNTH_5143: Initial blocks are ignored for synthesis
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    addr = 0;
    data = 0;
    #10 addr = 1;
    #10 data = 1;
    #10 addr = 2;
    #10 data = 2;
    #10 $finish;
  end
`endif // SYNTHESIS

endmodule
