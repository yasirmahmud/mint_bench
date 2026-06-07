module while_loop_ex1 (input wire clk, input wire rst_n, output reg [3:0] out_val);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin out_val <= 4'd0;
 end else begin integer i = 0;
 while (i < 5) begin out_val = i;
 i = i + 1;
 end end end endmodule
