module rule8_ex1 (input a, input en1, input en2, input en1_n, input en2_n, output z);
 wire tg_out_1;
 my_tg_cell tg_inst_1 (.in_data(a), .en(en1), .out_data(tg_out_1));
 my_tg_cell tg_inst_2 (.in_data(tg_out_1), .en(en2), .out_data(z));
 endmodule
