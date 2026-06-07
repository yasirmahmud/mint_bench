module top_ex2 (input clk, rst, output [7:0] out_data);
 reg [7:0] internal_data;
 sub_module sub_inst (.a(1'b0), .b());
 always @(posedge clk or posedge rst) begin if (rst) begin internal_data <= 8'h00;
 end else begin internal_data <= sub_inst.my_func(internal_data);
 end end assign out_data = internal_data;
 endmodule
