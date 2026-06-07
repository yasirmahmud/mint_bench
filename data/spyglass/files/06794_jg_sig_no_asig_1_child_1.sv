module unassigned_wire_read (
    output wire out_val
);
    wire unassigned_sig;

    assign unassigned_sig = 1'bx; // Explicitly assign 'x' to resolve W123 and maintain the 'x' behavior for out_val
    assign out_val = unassigned_sig;

endmodule
