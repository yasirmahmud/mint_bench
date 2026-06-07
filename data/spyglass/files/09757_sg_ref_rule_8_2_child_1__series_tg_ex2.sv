module series_tg_ex2 (input wire data_in, input wire ctrl1, input wire ctrl2, output wire data_out);
 wire intermediate_node;
 tg_cell tg_inst1 (.out(intermediate_node), .in(data_in), .ctrl(ctrl1), .ctrl_n(~ctrl1));
 tg_cell tg_inst2 (.out(data_out), .in(intermediate_node), .ctrl(ctrl2), .ctrl_n(~ctrl2));
 endmodule
