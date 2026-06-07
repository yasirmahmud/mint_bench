module star_ex2 (input clk_in, rst_in, input d, output reg q);
 wire my_rst_derived = rst_in | clk_in;
 always @(posedge clk_in or posedge my_rst_derived) begin if (my_rst_derived) q <= 1'b0;
 else q <= d;
 end endmodule
