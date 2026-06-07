module curve_synth_5034_20260111_230756_599726_w49296_attempt11 (
    input wire [4:0] data_in,
    output reg out_val
);

always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latches
    // SYNTH_5034: Comparison with don't care ('x') or tristate ('z') will always be false.
    // In Verilog, for a standard 'case' statement, patterns containing 'x' are treated
    // as specific unknown values. When 'data_in' (which typically carries 0s or 1s)
    // is compared using '==' (implied by 'case') against a pattern with 'x' (e.g., 5'b10x10),
    // the comparison `data_in == 5'b10x10` will evaluate to 'X' (unknown) in simulation
    // if the corresponding bit in 'data_in' is 0 or 1. In synthesis, a condition that
    // evaluates to 'X' is typically treated as 'false', making this branch unreachable
    // and inferring no logic for it.
    case (data_in)
        5'b10x10: out_val = 1'b1; // Target violation line: Comparison with 'x' in pattern
        default: out_val = 1'b0; // Ensures all possible inputs are covered
    endcase
end

endmodule
