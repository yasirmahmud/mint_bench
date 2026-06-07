module unassigned_reg_read (
    input wire clk,
    output reg out_reg
);
    reg unassigned_reg; // Declared but never assigned

    always @(posedge clk) begin
        out_reg <= unassigned_reg; // Read here
    end

endmodule
