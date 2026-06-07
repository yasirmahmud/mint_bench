module latch_infer_ex2(input i_data, input i_en, output reg o_latch_q);
 always @* begin if (i_en) o_latch_q = i_data;
 end endmodule
