module unassigned_wire_read (
    input wire clk,
    output wire out_val
);
    wire unassigned_sig; // Declared but never assigned

    assign out_val = unassigned_sig; // Read here

endmodule
