module star_ex1 (output reg out);
 wire [1:0] x_select_sig;
 assign x_select_sig = 2'bxx;
 always @(*) begin
  casex (x_select_sig)
    2'b00: out = 1'b0;
    2'b01: out = 1'b1;
    default: out = 1'bx;
  endcase // Corrected from endcasex
 end
endmodule // Added missing endmodule
