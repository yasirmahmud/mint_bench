module curve_starc05_1_4_3_4_20260111_110822_attempt9 (
    input main_clk, // Main system clock
    input aux_clk,  // This signal will be classified as a clock
    input data_in,  // General data input
    output reg q_aux_clocked,
    output reg q_main_clocked_with_aux_as_enable
);

    // Block 1: Establish 'aux_clk' as a clock signal.
    // SpyGlass will identify 'aux_clk' as a clock due to its use here.
    always @(posedge aux_clk) begin
        q_aux_clocked <= data_in;
    end

    // Block 2: Use 'aux_clk' (which is now classified as a clock) as a non-clock signal.
    // Here, 'aux_clk' is used as an enable for a flip-flop clocked by 'main_clk'.
    // This usage as a conditional signal will trigger the STARC05-1.4.3.4 violation.
    always @(posedge main_clk) begin
        if (aux_clk) begin // 'aux_clk' is used as an enable, a non-clock usage.
            q_main_clocked_with_aux_as_enable <= data_in;
        end
    end

endmodule
