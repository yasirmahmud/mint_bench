module signal_modified_after_read_ex1(input wire i_val, output reg o_val);
 reg r_sig;
 always_comb begin if(i_val) o_val = r_sig;
 r_sig = i_val;
 end endmodule
