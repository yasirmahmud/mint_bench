module curve_w215_20260111_183833_196377_w36056_attempt10 (
    input wire clk,
    input wire rst,
    output reg out_bit
);

    // Declare an integer variable. In Verilog-2001, 'integer' variables are typically 32-bit.
    integer my_integer_var;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            my_integer_var <= 0;
            out_bit <= 1'b0;
        end else begin
            // Increment the integer variable to ensure it is active and its value changes.
            my_integer_var <= my_integer_var + 1;
            
            // Trigger W215: Inappropriate bit select for int_bit_sel variable.
            // SpyGlass flags direct bit selection on an 'integer' type variable.
            // This single instance of bit selection will trigger exactly one W215 violation.
            out_bit <= my_integer_var[0];
        end
    end

endmodule
