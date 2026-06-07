`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt4 (
    input wire enable,
    input wire data_in,
    output wire out_data
);

    // Declare 'my_net_signal' as a wire type (a net).
    wire my_net_signal;

    // STX_VE_361: Procedural assignment statement cannot drive a net
    // This 'always @(*)' block is a procedural context. 
    // Attempting to assign to 'my_net_signal' (a wire) within this block
    // will trigger the violation on the line below.
    always @(*) begin
        my_net_signal = enable ? data_in : 1'b0; // This line causes the STX_VE_361 violation.
    end

    // The output uses the problematic wire to ensure it is not optimized away.
    assign out_data = my_net_signal;

endmodule
