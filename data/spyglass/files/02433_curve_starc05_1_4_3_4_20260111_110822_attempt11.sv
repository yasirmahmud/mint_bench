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

    // Block 2: Use 'async_clk_source' (classified as a clock) as a non-clock signal.
    // Here, 'async_clk_source' is used as a data condition within a flip-flop
    // clocked by 'sys_clk'. This usage will trigger the STARC05-1.4.3.4 violation.
    always @(posedge sys_clk) begin
        if (async_clk_source) begin // Violation: Clock signal used as a conditional input
            sync_out <= 1'b1;
        end else begin
            sync_out <= 1'b0;
        end
    end

endmodule
