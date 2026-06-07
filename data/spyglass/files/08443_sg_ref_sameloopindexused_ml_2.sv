module same_loop_index_ex2;
 reg [3:0] k;
 reg [7:0] data1, data2;
 always @* begin for (k = 0; k < 4; k = k + 1) begin data1 = k;
 end end always @* begin for (k = 0; k < 8; k = k + 1) begin data2 = k;
 end end endmodule
