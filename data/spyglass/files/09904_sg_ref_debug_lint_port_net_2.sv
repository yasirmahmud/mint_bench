module fanout_ex2(input in_sig);
wire high_fanout_net;
assign high_fanout_net=in_sig;
wire [19:0] w_vec;
assign w_vec={20{high_fanout_net}};
endmodule
