module curve_w215_20260112_010758_145506_w47152_attempt16 (
    input wire clk,
    input wire reset_n,
    input wire enable_in,
    output reg result_bit
);

    integer my_counter; // Declare an integer variable

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            my_counter <= 32'h0; // Reset the integer to avoid undefined state
            result_bit <= 1'b0;
        end else begin
            if (enable_in) begin
                my_counter <= my_counter + 1; // Update the integer to ensure it's used and changes value
            end
            // SpyGlass rule W215 flags an "Inappropriate bit select for int_bit_sel variable".
            // Performing a bit select on an 'integer' type variable (my_counter[1]) is flagged here.
            // This line is expected to trigger exactly one W215 violation.
            result_bit <= my_counter[1]; // Triggers W215
        end
    end

endmodule
