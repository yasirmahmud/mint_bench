module unreachable_ml_ex1;
 reg [0:0] select_val;
 reg out_reg;
 always @* begin case (select_val) 1'b0: out_reg = 1'b0;
 1'b1: out_reg = 1'b1;
 default: out_reg = 1'b0;
 endcase end endmodule
