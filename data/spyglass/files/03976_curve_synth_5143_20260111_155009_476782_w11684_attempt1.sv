module curve_synth_5143_20260111_155009_476782_w11684_attempt1 ();

reg my_state; // A simple register to demonstrate initialization

initial begin
    // This initial block will be ignored by synthesis tools,
    // which triggers the SYNTH_5143 violation.
    my_state = 1'b0;
end

endmodule
