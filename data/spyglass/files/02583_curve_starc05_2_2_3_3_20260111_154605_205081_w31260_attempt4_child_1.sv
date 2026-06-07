module curve_starc05_2_2_3_3_20260111_154605_205081_w31260_attempt4 (
    input wire clk,
    input wire reset,
    input wire data_in_a,
    input wire data_in_b,
    output reg buffer_full
);

// Minimal sequential block to demonstrate the violation
always @(posedge clk or posedge reset) begin
    if (reset) begin
        buffer_full <= 1'b0;
    end else begin
        // The original design had multiple assignments to buffer_full.
        // In Verilog, the last assignment in a sequential block takes precedence.
        // To preserve the functional behavior (where buffer_full would take the value of data_in_b
        // in the non-reset state due to the last assignment winning) and resolve the STARC05-2.2.3.3
        // and W415a violations, we remove the redundant first assignment.
        buffer_full <= data_in_b;
    end
end

endmodule
