module curve_starc05_1_4_3_4_20260111_110822_attempt8 (
    input clk_main,         // Main system clock
    input rstn,             // This signal is intentionally named 'rstn' to match violation context
    input data_in,          // General data input for a flop
    output reg q_rstn_as_clk,  // Output of a flop clocked by 'rstn'
    output reg q_rstn_as_data  // Output of a flop using 'rstn' as data
);

    // This block uses 'rstn' as the clock signal for sequential logic.
    // This explicit usage in an 'always @(posedge rstn)' block is intended
    // to classify 'rstn' as a *clock* signal by SpyGlass, rather than just a reset.
    always @(posedge rstn) begin
        q_rstn_as_clk <= data_in; // Synchronous data operation
    end

    // This block uses 'rstn' as a data input for a flip-flop clocked by 'clk_main'.
    // Since 'rstn' has been classified as a *clock* signal by the previous 'always' block,
    // its subsequent usage as a data input here should trigger the STARC05-1.4.3.4 violation:
    // "Clock signal 'rstn' used as a non-clock (Used with name 'rstn')".
    always @(posedge clk_main) begin
        q_rstn_as_data <= rstn; // 'rstn' (classified as a clock) used as non-clock (data input)
    end

endmodule
