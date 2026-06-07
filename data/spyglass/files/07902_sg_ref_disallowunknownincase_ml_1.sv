module DisallowUnknownInCase_ML_ex1();
reg [1:0] sel;
reg out;
always @* begin out = 1'b0;
case (sel) 2'b00: out = 1'b1;
 2'b0x: out = 1'b0;
 default: out = 1'b0;
 endcase end endmodule
