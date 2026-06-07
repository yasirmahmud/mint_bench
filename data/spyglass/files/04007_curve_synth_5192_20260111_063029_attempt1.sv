module curve_synth_5192_20260111_063029_attempt1 (
    input clk,
    input rst,
    input d,
    output reg q
);

// SYNTH_5192: Signal edge of "rst" used in condition of if statement does not match that specified in the sensitivity list of always block
always @(posedge clk or posedge rst) begin
    if (~rst) begin // Violation: Sensitivity list has 'posedge rst', but the condition 'if (~rst)' checks for a negative edge (rst == 0).
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
