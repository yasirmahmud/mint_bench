module scan_chain_ex2 (input clk, rst, si, output so);
 reg q1;
 always @(posedge clk or posedge rst) begin if (rst) q1 <= 1'b0;
 else q1 <= si;
 end always @(posedge clk or posedge rst) begin if (rst) so <= 1'b0;
 else so <= q1;
 end endmodule
