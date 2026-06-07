module curve_w215_20260112_010758_145506_w47152_attempt14 (
    input wire clk,
    input wire reset_n,
    output reg out_bit0,
    output reg out_bit1,
    output reg out_bit2,
    output reg out_bit3
);

    integer my_integer_value;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            my_integer_value <= 0;
            out_bit0 <= 0;
            out_bit1 <= 0;
            out_bit2 <= 0;
            out_bit3 <= 0;
        end else begin
            my_integer_value <= my_integer_value + 1; // Increment to demonstrate active variable

            // SpyGlass rule W215 flags an "Inappropriate bit select for int_bit_sel variable".
            // Each of the following assignments performs a distinct bit select on the 'integer' variable 'my_integer_value'.
            // This will trigger exactly four W215 violations, one for each distinct bit select.
            out_bit0 <= my_integer_value[0]; // Triggers W215 (instance 1)
            out_bit1 <= my_integer_value[1]; // Triggers W215 (instance 2)
            out_bit2 <= my_integer_value[2]; // Triggers W215 (instance 3)
            out_bit3 <= my_integer_value[3]; // Triggers W215 (instance 4)
        end
    end

endmodule
