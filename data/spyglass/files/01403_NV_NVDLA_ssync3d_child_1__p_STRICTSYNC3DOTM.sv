module p_STRICTSYNC3DOTM (
    input SRC_CLK,
    input SRC_D_NEXT,
    output SRC_D,
    input DST_CLK,
    output DST_Q,
    input ATPG_CTL,
    input TEST_MODE
);

// This is a behavioral model to define the black-box primitive
// and resolve linting violations. It functionally implements
// a 3-stage synchronizer.

// Register input in source clock domain
reg src_d_reg;
always @(posedge SRC_CLK) begin
    src_d_reg <= SRC_D_NEXT;
end
assign SRC_D = src_d_reg; // Output the registered source data

// Three-stage synchronizer in destination clock domain
reg sync_r1, sync_r2, sync_r3;
always @(posedge DST_CLK) begin
    sync_r1 <= src_d_reg; // First stage samples SRC_D
    sync_r2 <= sync_r1;   // Second stage
    sync_r3 <= sync_r2;   // Third stage
end
assign DST_Q = sync_r3;

// ATPG_CTL and TEST_MODE are typically used for scan/test
// and are tied off in a functional behavioral model.

endmodule
