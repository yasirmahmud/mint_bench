module curve_w240_20260111_160401_066985_w30032_attempt3 (
    input [7:0] data_in,
    input clk,
    input data_valid, // This input will be declared but not read.
    output reg [7:0] data_out
);

// LINT FIX: To resolve 'Input declared but not read' warning for 'data_valid',
// assign it to an unused wire. This preserves the functional intent that
// data_valid is declared but not functionally used by the core logic driving data_out.
wire _unused_data_valid = data_valid;

always @(posedge clk) begin
    // Latch data_in to data_out, ignoring 'data_valid'.
    data_out <= data_in;
end

endmodule
