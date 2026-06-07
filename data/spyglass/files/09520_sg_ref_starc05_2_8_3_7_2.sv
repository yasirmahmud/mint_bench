module my_module_ex2 (input [1:0] in_a, output reg out_b);
 reg [1:0] sel_sig;
 always @(*) begin sel_sig = 2'b0x;
 casex (sel_sig) 2'b00: out_b = 1'b0;
 2'b01: out_b = 1'b1;
 default: out_b = 1'b0;
 endcase end endmodule
