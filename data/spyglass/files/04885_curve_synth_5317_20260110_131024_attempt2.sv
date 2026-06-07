module curve_synth_5317_20260110_131024_attempt2 (
    input wire clk,
    input wire data_in,
    output reg data_out
);

always @(data_in) begin // Level-sensitive always block timing control
    data_out = @(posedge clk) data_in; // Embedded event control in RHS
end

endmodule
