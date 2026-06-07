module deepmux_ex1(input clk, input [3:0] sel, input [7:0] data_in, output reg [7:0] data_out);
 always @(posedge clk) begin if (sel == 4'd0) data_out = data_in;
 else if (sel == 4'd1) data_out = data_in + 1;
 else if (sel == 4'd2) data_out = data_in + 2;
 else if (sel == 4'd3) data_out = data_in + 3;
 else if (sel == 4'd4) data_out = data_in + 4;
 else data_out = 8'd0;
 end endmodule
