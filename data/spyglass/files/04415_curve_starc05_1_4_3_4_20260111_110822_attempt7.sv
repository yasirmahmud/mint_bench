module curve_starc05_1_4_3_4_20260111_110822_attempt7 (
    input clk,
    input rstn, // This signal is intentionally named 'rstn' to prompt SpyGlass classification as a reset.
    output reg q_reset,
    output reg q_data
);

// This block uses 'rstn' as an asynchronous reset.
// This usage helps SpyGlass explicitly classify 'rstn' as a reset signal.
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        q_reset <= 1'b0;
    end else begin
        q_reset <= ~q_reset; // Dummy data operation for q_reset
    end
end

// This block uses 'rstn' purely as a synchronous data input for 'q_data'.
// Since 'rstn' has been classified as a reset by the previous block, this usage
// as a data input should trigger the STARC05-1.4.3.4 violation: 
// "Clock signal 'rstn' used as a non-clock (Used with name 'rstn')".
always @(posedge clk) begin
    q_data <= rstn; // 'rstn' used as a non-clock (data input)
end

endmodule
