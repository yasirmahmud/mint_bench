module curve_starc05_1_4_3_4_20260111_110822_attempt4 (
    input clk,
    input rstn,
    input din,
    output reg dout
);

reg control_flop;
reg data_flop;

// Block 1: 'rstn' is used as an asynchronous reset for 'control_flop'.
// This establishes 'rstn' as a critical control signal, which EDA tools
// like SpyGlass often categorize as a clock-like signal for analysis purposes.
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        control_flop <= 1'b0;
    end else begin
        control_flop <= din;
    end
end

// Block 2: 'rstn' is used as a data input to 'data_flop'.
// This is the "non-clock" usage. Since 'rstn' was identified as a critical
// control (reset) signal in Block 1, using it directly as data here
// triggers the STARC05-1.4.3.4 violation: "Clock signal ... used as a non-clock".
always @(posedge clk) begin
    data_flop <= rstn; // 'rstn' is assigned as a data source for a flip-flop
end

assign dout = data_flop;

endmodule
