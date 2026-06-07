module W398_ex2;
 reg [2:0] choice;
 reg out_reg;
 always @(*) begin casex (choice) 3'b100: out_reg = 1'b0;
 3'b10?: out_reg = 1'b1;
 default: out_reg = 1'b0;
 endcase end endmodule
