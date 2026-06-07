module curve_starc05_1_4_3_4_20260111_110822_attempt11 (
    input sys_clk,
    input async_clk_source,
    output reg sync_out,
    output reg async_out
);

    // Block 1: Establish 'async_clk_source' as a clock signal.
    // SpyGlass will identify 'async_clk_source' as a clock due to its use here.
    always @(posedge async_clk_source) begin
        async_out <= ~async_out; // Simple toggle, ensures async_clk_source is a clock
    end

    // SpyGlass STARC05-1.4.3.4 Violation Fix:
    // 'async_clk_source' is identified as a clock and cannot be used directly as a data input
    // to a flip-flop clocked by 'sys_clk'.
    // To resolve this, synchronize 'async_clk_source' into the 'sys_clk' domain
    // using a 2-flop synchronizer.

    reg async_clk_source_s1;
    reg async_clk_source_s2;

    always @(posedge sys_clk) begin
        async_clk_source_s1 <= async_clk_source; // First stage
        async_clk_source_s2 <= async_clk_source_s1; // Second stage for metastability resolution
    end

    // Block 2: Use 'async_clk_source_s2' (synchronized data) as a non-clock signal.
    // 'async_clk_source_s2' is now a stable data signal in the 'sys_clk' domain,
    // resolving the STARC05-1.4.3.4 violation.
    always @(posedge sys_clk) begin
        if (async_clk_source_s2) begin // Fixed: Using synchronized signal
            sync_out <= 1'b1;
        end else begin
            sync_out <= 1'b0;
        end
    end

endmodule
