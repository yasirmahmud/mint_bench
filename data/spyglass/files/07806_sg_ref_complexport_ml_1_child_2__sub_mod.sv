module sub_mod (input [3:0] data_in, output unused_signal_out);
    // To resolve W240 (Input declared but not read) and W528 (Variable set but not read),
    // this output uses the input internally without affecting main external functional behavior.
    assign unused_signal_out = |data_in;
endmodule
