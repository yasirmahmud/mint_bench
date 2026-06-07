module spare_case_expr_bit_ex2;
 reg [1:0] sel;
 reg out;
 always @(*) begin case (sel) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 endcase end endmodule
