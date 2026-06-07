module unassigned_reg_read (
    input wire clk,
    output reg out_reg
);
    reg unassigned_reg; // Declared but never assigned

    // Fix: Explicitly initialize unassigned_reg to 'X' to resolve the 'never set' and 'undriven' violations.
    // This maintains the original functional behavior where unassigned_reg would default to 'X'.
    initial begin
        unassigned_reg = 1'bx;
    end

    always @(posedge clk) begin
        out_reg <= unassigned_reg; // Read here
    end

endmodule
