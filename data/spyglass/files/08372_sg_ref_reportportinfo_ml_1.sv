module ReportPortInfo_ex1 (input clk, input rst_n, input [7:0] in_data, output [15:0] out_data);
 assign out_data = {in_data, in_data};
 endmodule
