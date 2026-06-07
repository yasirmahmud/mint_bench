// Define simple D-flip-flop modules to resolve ErrorAnalyzeBBox violations.
// Their outputs are declared but unconnected in the dtag_misc module, which is maintained.
module mj_s_ff_s_d (output reg out, input in, input clk);
    always @(posedge clk) begin
        out <= in;
    end
endmodule
