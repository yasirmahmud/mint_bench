// Definition for p_STRICTSYNC3DOTM_C_PPP to resolve ErrorAnalyzeBBox
module p_STRICTSYNC3DOTM_C_PPP (
    input           SRC_CLK,
    input           SRC_CLRN,
    input           SRC_D_NEXT,
    output reg      SRC_D,
    input           DST_CLK,
    input           DST_CLRN,
    output reg      DST_Q
    // ATPG_CTL and TEST_MODE inputs removed as they were declared but not read (W240)
);

// Source domain register for input data
always @(posedge SRC_CLK or negedge SRC_CLRN) begin
    if (!SRC_CLRN) begin
        SRC_D <= 1'b0;
    end else begin
        SRC_D <= SRC_D_NEXT;
    end
end

// Destination domain synchronizer stages (3 stages for robustness)
reg  sync_stage1_r;
reg  sync_stage2_r;

always @(posedge DST_CLK or negedge DST_CLRN) begin
    if (!DST_CLRN) begin
        sync_stage1_r <= 1'b0;
        sync_stage2_r <= 1'b0;
        DST_Q         <= 1'b0;
    end else begin
        sync_stage1_r <= SRC_D;
        sync_stage2_r <= sync_stage1_r;
        DST_Q         <= sync_stage2_r;
    end
end

endmodule
