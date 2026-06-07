module my_module_ex2 (input a, input b, output reg out);
 always @(*) begin case (a + b) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
