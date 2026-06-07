module W392aL_ex1 (input enable, rst, data, output reg out1, out2);
 always @(enable or rst or data) begin if (~rst) out1 <= 1'b0;
 else if (enable) out1 <= data;
 end always @(enable or rst or data) begin if (rst) out2 <= 1'b0;
 else if (enable) out2 <= data;
 end endmodule
