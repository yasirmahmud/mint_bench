module my_tg_cell (input in_data, input en, input en_n, output out_data);
 assign out_data = en ? in_data : 1'bz;
 endmodule
