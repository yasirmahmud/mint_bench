module w253_ex2(input clk, input data_in);
 reg q;
 always @(posedge clk) begin
 q <= data_in;
 end
endmodule
