module wait_statement_ex1 (input clk, output reg out);
 always begin wait (clk);
 out <= ~out;
 end endmodule
