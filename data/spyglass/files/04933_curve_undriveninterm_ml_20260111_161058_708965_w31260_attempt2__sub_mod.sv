module sub_mod (
    input wire sub_input,
    output wire sub_output
);
    // Use sub_input to prevent it from being unused in this module
    assign sub_output = sub_input;
endmodule
