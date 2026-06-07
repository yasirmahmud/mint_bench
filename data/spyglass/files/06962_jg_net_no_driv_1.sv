module no_drive_assign (
    output wire out_val
);
    wire my_signal; // Declared but not driven

    assign out_val = my_signal; // 'my_signal' is loaded but has no driver

endmodule
