module curve_w215_20260112_010758_145506_w47152_attempt13 (
    input wire clk,
    input wire reset_n,
    output reg out_bit_0,
    output reg out_bit_1,
    output reg out_bit_2,
    output reg out_bit_3
);

    integer int_val_A;
    integer int_val_B;
    integer int_val_C;
    integer int_val_D;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            int_val_A <= 0;
            int_val_B <= 0;
            int_val_C <= 0;
            int_val_D <= 0;
            out_bit_0 <= 0;
            out_bit_1 <= 0;
            out_bit_2 <= 0;
            out_bit_3 <= 0;
        end else begin
            int_val_A <= int_val_A + 1;
            int_val_B <= int_val_B + 2;
            int_val_C <= int_val_C + 3;
            int_val_D <= int_val_D + 4;

            // Each of the following lines performs a bit select on an 'integer' variable.
            // SpyGlass rule W215 flags this as an "Inappropriate bit select for int_bit_sel variable".
            // Since there are four distinct instances of this operation on four different integer variables
            // (or with different bit indices), exactly four W215 violations are expected.
            out_bit_0 <= int_val_A[0]; // Triggers W215 (instance 1)
            out_bit_1 <= int_val_B[1]; // Triggers W215 (instance 2)
            out_bit_2 <= int_val_C[2]; // Triggers W215 (instance 3)
            out_bit_3 <= int_val_D[3]; // Triggers W215 (instance 4)
        end
    end

endmodule
