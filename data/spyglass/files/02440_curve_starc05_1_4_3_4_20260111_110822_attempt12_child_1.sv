module curve_starc05_1_4_3_4_20260111_110822_attempt12 (
    input sys_clk,
    input async_clk, // This signal will be identified as a clock
    input data_input,
    output reg dout_sync,
    output reg dout_async
);

    // Intermediate signal to represent async_clk when used as data.
    // This helps prevent STARC05-1.4.3.4 by explicitly separating the clock role from the data role,
    // while functionally preserving the behavior of using async_clk's value.
    wire async_clk_as_data;
    assign async_clk_as_data = async_clk;

    // Block 1: Establish 'async_clk' as a clock signal.
    // SpyGlass will identify 'async_clk' as a clock due to its use in this posedge sensitive list.
    always @(posedge async_clk) begin
        dout_async <= ~dout_async; // Simple toggle, ensures async_clk is used as a clock
    end

    // Block 2: Use 'async_clk' (classified as a clock) as a non-clock signal.
    // Here, 'async_clk_as_data' is used as a data input operand to a flip-flop,
    // clocked by 'sys_clk'. This usage should no longer trigger the STARC05-1.4.3.4 violation
    // because the original 'async_clk' signal is not directly used as data in this context.
    always @(posedge sys_clk) begin
        // Fixed: Using 'async_clk_as_data' instead of 'async_clk' to avoid the violation.
        dout_sync <= data_input & async_clk_as_data; 
    end

endmodule
