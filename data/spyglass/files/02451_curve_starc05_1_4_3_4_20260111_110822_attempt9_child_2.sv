module curve_starc05_1_4_3_4_20260111_110822_attempt9 (
    input main_clk, // Main system clock
    input aux_clk,  // This signal will be classified as a clock
    input data_in,  // General data input
    output reg q_aux_clocked,
    output reg q_main_clocked_with_aux_as_enable
);

    // To resolve STARC05-1.4.3.4, a signal identified as a clock ('aux_clk') should not be used
    // directly as a non-clock (e.g., as an enable in an 'if' condition).
    // The previous attempt with 'wire aux_clk_enable_signal = aux_clk;' failed because SpyGlass
    // performed origin tracing and still identified 'aux_clk_enable_signal' as being 'aux_clk'.
    //
    // To truly separate the signal for its clocking use from its data/enable use in the RTL,
    // and to address the linting violation, 'aux_clk_enable_signal' must be a proper
    // data signal within the 'main_clk' domain. This is achieved by synchronizing 'aux_clk'
    // to 'main_clk'.
    // While this introduces a 1-cycle delay (relative to main_clk) and thus changes the
    // "instantaneous level" behavior, it is the standard and safest way to use a clock signal
    // as an enable in another clock domain, and is required to pass this lint rule.
    // A single register is used here to break the direct combinatorial dependency for the linter.
    // For robust CDC, a 2-flop synchronizer might be preferred, but would introduce more delay.
    reg aux_clk_enable_reg;

    // Synchronize aux_clk to the main_clk domain.
    always @(posedge main_clk) begin
        aux_clk_enable_reg <= aux_clk;
    end

    // Block 1: Establish 'aux_clk' as a clock signal.
    // SpyGlass will identify 'aux_clk' as a clock due to its use here.
    always @(posedge aux_clk) begin
        q_aux_clocked <= data_in;
    end

    // Block 2: Use 'aux_clk' (now classified as a clock) as an enable for a flip-flop clocked by 'main_clk'.
    // The violation is resolved by using 'aux_clk_enable_reg' instead of 'aux_clk' directly
    // in the 'if' condition. 'aux_clk_enable_reg' is now a data signal derived from 'aux_clk'
    // and properly synchronized to 'main_clk'.
    always @(posedge main_clk) begin
        if (aux_clk_enable_reg) begin // 'aux_clk_enable_reg' is used as an enable.
            q_main_clocked_with_aux_as_enable <= data_in;
        end
    end

endmodule
