module exotic_clock_ex1(input clk_in, output reg gclk);
 reg [1:0] cnt;
 always @(posedge clk_in) cnt <= cnt + 1;
 always @(posedge clk_in or negedge clk_in) begin if (clk_in == 0) begin if (cnt == 0) gclk <= 1;
 end else begin if (cnt == 1) gclk <= 0;
 end end endmodule
