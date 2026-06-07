module curve_synth_5378_20260111_020413_attempt1 (
    input clk_in,
    input reset_in,
    input data_in,
    output reg data_out
);

    // SYNTH_5378: Complex expression 'posedge (clk_in | reset_in)' is not allowed in event specification for synthesis
    always @(posedge (clk_in | reset_in)) begin
        data_out <= data_in;
    end

endmodule
