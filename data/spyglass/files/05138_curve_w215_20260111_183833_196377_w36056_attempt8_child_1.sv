module curve_w215_20260111_183833_196377_w36056_attempt8 (
    input wire clk,
    input wire rst,
    output reg [3:0] out_bits
);

    // Declare four separate integer variables.
    // In Verilog-2001, 'integer' variables are typically 32-bit signed.
    integer i0, i1, i2, i3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_bits <= 4'b0;
            i0 = 0; i1 = 0; i2 = 0; i3 = 0; // Initialize integers on reset
        end else begin
            // Assign values to the integer variables.
            i0 = 0;
            i1 = 1;
            i2 = 2;
            i3 = 3;

            // To avoid W215, instead of bit-selecting from an integer, 
            // assign the specific bit value directly. Given the constant
            // assignments, we know the exact LSB value.
            out_bits[0] <= 1'b0; // i0[0] is 0
            out_bits[1] <= 1'b1; // i1[0] is 1
            out_bits[2] <= 1'b0; // i2[0] is 0
            out_bits[3] <= 1'b1; // i3[0] is 1
        end
    end

endmodule
