module curve_starc05_1_4_3_4_20260111_110822_attempt1 (
    input clk,
    input rstn,
    input din,
    output reg dout
);

reg q;

// rstn is identified as an asynchronous reset due to its use in this block
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin // Asynchronous reset condition
        q <= 1'b0;
    end else begin
        q <= din;
    end
end

// rstn is subsequently used in combinatorial logic as a data path element
// This triggers STARC05-1.4.3.4 as a clock/reset signal is used as a non-clock.
always @(*) begin
    if (rstn) begin
        dout = q;
    end else begin
        dout = ~q;
    end
end

endmodule
