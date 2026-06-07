module compare_zero_32 (
    output out,
    input  [31:0] in
);
    assign out = (in == 32'h0);
endmodule
