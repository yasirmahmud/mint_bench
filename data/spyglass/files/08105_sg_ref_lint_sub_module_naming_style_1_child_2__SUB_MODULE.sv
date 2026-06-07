module SUB_MODULE (
    input in_val,
    output out_val
);
    // The previous 'wire dummy_signal;' was insufficient to resolve the "empty definition" warning.
    // Adding ports and a simple assignment makes the module non-empty without altering its unspecified functional behavior.
    assign out_val = in_val;
endmodule
