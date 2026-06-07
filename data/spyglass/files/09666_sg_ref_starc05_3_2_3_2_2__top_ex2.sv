module top_ex2;
 reg [2:0] a_sig;
 sub_ex2 inst_ex2 (.in_port({2'b0, a_sig}));
 endmodule
