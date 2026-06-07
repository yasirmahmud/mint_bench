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

            // Performing a bit select on an integer variable is considered
            // an "inappropriate bit select for int_bit_sel variable" by SpyGlass W215.
            // Each instance below will trigger one W215 violation, resulting in 4 violations.
            out_bits[0] <= i0[0]; // Triggers W215 (instance 1)
            out_bits[1] <= i1[0]; // Triggers W215 (instance 2)
            out_bits[2] <= i2[0]; // Triggers W215 (instance 3)
            out_bits[3] <= i3[0]; // Triggers W215 (instance 4)
        end
    end

endmodule
