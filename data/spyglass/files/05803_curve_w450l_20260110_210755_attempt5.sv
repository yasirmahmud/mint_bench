module curve_w450l_20260110_210755_attempt5 (
    input [1:0] enable_bus_a,
    input       data_in_a,
    output reg  data_out_a,

    input [2:0] enable_bus_b,
    input       data_in_b,
    output reg  data_out_b
);

    // W450L violation 1: Multi-bit expression 'enable_bus_a' used as latch enable.
    // A latch is inferred for 'data_out_a' because it is not assigned when 'enable_bus_a' is 2'b00.
    always @*
        if (enable_bus_a) // 'enable_bus_a' is a [1:0] multi-bit expression
            data_out_a = data_in_a;

    // W450L violation 2: Multi-bit expression 'enable_bus_b' used as latch enable.
    // A latch is inferred for 'data_out_b' because it is not assigned when 'enable_bus_b' is 3'b000.
    always @* begin
        if (enable_bus_b) begin // 'enable_bus_b' is a [2:0] multi-bit expression
            data_out_b = data_in_b;
        end
    end

endmodule
