module STARC02_2_1_10_6_ex2 (output out_val);
 parameter SELECTOR = 1;
 generate if (SELECTOR == 0) begin : gen_sel_0 assign out_val = 1'b0;
 end else if (SELECTOR == 1) begin : gen_sel_1 assign out_val = 1'b1;
 end else begin : gen_sel_default assign out_val = 1'bx;
 end endgenerate endmodule
