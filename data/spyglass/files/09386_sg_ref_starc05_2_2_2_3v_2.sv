module star_c05_2_2_2_3v_ex2(input clk, input rst, input in_data, output reg out_data);
 always @(posedge clk or posedge rst) begin if (rst) begin out_data <= 1'b0;
 end else begin wait (in_data == 1'b1);
 out_data <= in_data;
 end end endmodule
