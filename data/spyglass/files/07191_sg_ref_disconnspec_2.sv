module DisconnSpec_ex2 (input clk, output reg out);
 specify pulsestyle_ondetect clk;
 endspecify always @(posedge clk) out <= ~out;
 endmodule
