module curve_stx_ve_349_20260110_111848_attempt5 (
    input wire dummy_in,
    output reg dummy_out
);

integer i;

always @(*) begin
    dummy_out = 1'b0; // Default assignment to avoid potential uninitialized warnings
    for (i = 0; i < 5; i = i + 1) begin
        if (i == 3) begin
            // The 'break' statement is a Verilog-2005 construct.
            // When parsing under a Verilog-2001 standard, SpyGlass interprets
            // 'break' as a call to an undeclared task or function, leading to STX_VE_349.
            break;
        end
    end
    dummy_out = dummy_in; // Assign a value to the output
end

endmodule
