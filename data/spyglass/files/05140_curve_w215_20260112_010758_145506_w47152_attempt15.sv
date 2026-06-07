module curve_w215_20260112_010758_145506_w47152_attempt15 (
    input wire clk,
    input wire reset_n,
    input wire [1:0] sel, // Selector for different bit positions
    output reg out_bit
);

    integer my_integer;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            my_integer <= 0;
            out_bit <= 1'b0;
        end else begin
            my_integer <= my_integer + 1; // Keep the integer active to prevent unused signal warning

            // SpyGlass rule W215 flags an "Inappropriate bit select for int_bit_sel variable".
            // The following conditional assignments will each trigger a W215 violation
            // because they perform a bit select on an 'integer' type variable 'my_integer'.
            // This design ensures exactly four distinct W215 violations, one for each unique bit selection.
            case (sel)
                2'b00: begin
                    out_bit <= my_integer[0]; // Triggers W215 (instance 1)
                end
                2'b01: begin
                    out_bit <= my_integer[1]; // Triggers W215 (instance 2)
                end
                2'b10: begin
                    out_bit <= my_integer[2]; // Triggers W215 (instance 3)
                end
                2'b11: begin
                    out_bit <= my_integer[3]; // Triggers W215 (instance 4)
                end
                default: begin
                    // This default case is technically redundant as 'sel' is 2 bits, but included for robustness.
                    // It prevents any potential latch inference if 'sel' were wider or partially defined.
                    out_bit <= 1'b0;
                end
            endcase
        end
    end

endmodule
