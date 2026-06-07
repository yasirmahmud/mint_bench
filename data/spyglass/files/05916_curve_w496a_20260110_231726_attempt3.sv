module curve_w496a_20260110_231726_attempt3 (
    input wire [0:0] in_a,
    input wire [1:0] in_b,
    input wire [2:0] in_c,
    output reg out_a,
    output reg out_b,
    output reg out_c
);

    // Parameter for a tristate constant, used in one comparison
    parameter Z_CONST = 3'b01z;

    always @(*) begin
        // Initialize outputs to default values to avoid latches
        out_a = 1'b0;
        out_b = 1'b0;
        out_c = 1'b0;

        // Violation 1: Direct comparison of a single-bit input with 1'bz
        if (in_a == 1'bz) begin
            out_a = 1'b1;
        end

        // Violation 2: Comparison of a multi-bit input with a multi-bit constant containing 'z'
        if (in_b == 2'b1z) begin
            out_b = 1'b1;
        end

        // Violation 3: Comparison of another multi-bit input with a 'z' value defined via a parameter
        if (in_c == Z_CONST) begin
            out_c = 1'b1;
        end
    end

endmodule
