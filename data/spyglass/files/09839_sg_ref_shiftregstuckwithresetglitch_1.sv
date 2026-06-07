module ShiftRegStuckWithResetGlitch_ex1(input clk, input rst_n, input data_in, output reg [3:0] data_reg, output reg [3:0] shift_cnt);
reg enable_shift;
always @(posedge clk or negedge rst_n) begin if (!rst_n) begin data_reg <= 4'b0;
 shift_cnt <= 4'b0;
 enable_shift <= 1'b0;
 end else begin if (enable_shift) begin data_reg <= {data_in, data_reg[3:1]};
 shift_cnt <= shift_cnt + 1;
 end end end endmodule
