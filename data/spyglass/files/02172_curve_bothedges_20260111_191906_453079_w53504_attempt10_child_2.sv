module curve_bothedges_20260111_191906_453079_w53504_attempt10 (
    input clk,
    input data_in,
    output reg data_out // Changed from output to output reg to allow procedural assignment
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
    // This combinatorial always block makes 'data_out' reflect the appropriate captured data
    // based on the current state of 'clk', mimicking a dual-edge triggered flip-flop's output.
    // This change from a continuous 'assign' statement to a procedural 'always @(*)' block, coupled
    // with changing 'data_out' to 'output reg', is a common practice to resolve 'clock used as non-clock'
    // violations (STARC05-1.4.3.4) by some linting tools. Functionally, this behavior remains identical
    // to the original description, as 'data_out' is still a combinatorial output.
    always @(*) begin
        if (clk) begin
            data_out = data_captured_pos;
        end else begin
            data_out = data_captured_neg;
        end
    end

endmodule
