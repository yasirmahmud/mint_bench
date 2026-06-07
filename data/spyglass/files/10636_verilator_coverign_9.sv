module test_with_3;
  logic clk;
  logic [1:0] state_val;

  covergroup cg @(posedge clk);
    cp_state: coverpoint state_val {
      bins specific_state = {2'b10} with (state_val == 2'b10);
    }
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    state_val = 0;
    #10 state_val = 1;
    #10 state_val = 2;
    #10 state_val = 3;
    #10 $finish;
  end
endmodule
