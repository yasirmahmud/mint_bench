module curve_bothedges_20260111_191906_453079_w53504_attempt10 (
    input clk,
    input data_in,
    output data_out
);

    reg data_captured_pos; // Internal register to capture data on positive clock edge
    reg data_captured_neg; // Internal register to capture data on negative clock edge

    // Capture data_in on the positive edge of clk.
    // This resolves the 'bothedges' violation by isolating the positive edge sensitivity.
    // This is a standard synchronous always block, so the W442a violation (missing 'if' for async reset/set)
    // is not applicable here as there is no asynchronous control signal.
    always @(posedge clk) begin
        data_captured_pos <= data_in;
    end

    // Capture data_in on the negative edge of clk.
    // This further resolves the 'bothedges' violation by isolating the negative edge sensitivity.
    // Similarly, W442a is not applicable to this block.
    always @(negedge clk) begin
        data_captured_neg <= data_in;
    end

    // The 'data_out' signal should reflect the data captured by the most recent clock edge.
    // When 'clk' is high (following a posedge), 'data_captured_pos' holds the most recent data.
    // When 'clk' is low (following a negedge), 'data_captured_neg' holds the most recent data.
    // This continuous assignment makes 'data_out' a combinatorial output that effectively
    // mimics the behavior of a dual-edge triggered flip-flop's output, thus preserving functional behavior.
    // The output declaration for 'data_out' has been changed from 'output reg' to 'output' (wire type)
    // to allow it to be driven by a continuous assignment, which is the standard synthesizable approach
    // for combining outputs from multiple sequential elements without violating linting rules.
    assign data_out = clk ? data_captured_pos : data_captured_neg;

endmodule
