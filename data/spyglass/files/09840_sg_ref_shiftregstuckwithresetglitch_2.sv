module shift_reg_stuck_ex2 (input clk, input rst_n, input shift_en, input data_in, output reg data_out);
 reg [2:0] shift_count;
 reg [3:0] sreg;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin shift_count <= 3'b000;
 sreg <= 4'b0000;
 end else begin if (shift_en) begin if (shift_count == 3'b000) begin shift_count <= 3'b000;
 end else begin shift_count <= shift_count + 1;
 end sreg <= {sreg[2:0], data_in};
 end else begin shift_count <= 3'b000;
 end end end assign data_out = sreg[3];
 endmodule
