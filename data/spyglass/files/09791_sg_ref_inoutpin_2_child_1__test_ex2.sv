module test_ex2 (input in_port, output out_port);
 wire tmp_net;
 CELL_WITH_INOUT i1 (.A(in_port), .B(tmp_net), .X(out_port));
 CELL_WITHOUT_INOUT i2 (.P(tmp_net));
 endmodule
