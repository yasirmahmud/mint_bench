module waveform_ex2(input clk, input in1, input in2, output reg out);
 always @(posedge cllk) begin out <= #10 in1;
 out <= #20 in2;
 end endmodule
