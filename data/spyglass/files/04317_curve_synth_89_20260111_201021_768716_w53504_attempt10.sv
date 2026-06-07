module curve_synth_89_20260111_201021_768716_w53504_attempt10 (
    input clk,
    input reset,
    input enable,
    input [7:0] data_in,
    output [7:0] data_out
);

    // SYNTH_89: Initial assignment at declaration for 'data_reg' is ignored by synthesis.
    reg [7:0] data_reg = 8'hAA; // This initial assignment will be ignored by synthesis

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_reg <= 8'h00; // This reset value will be synthesized instead of the declaration's initial value
        end else if (enable) {
            data_reg <= data_in;
        }
    end

    assign data_out = data_reg;

endmodule
