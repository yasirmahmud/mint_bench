module curve_stx_ve_479_20260111_145104_attempt1 (
    input wire [3:0] in_data,
    output wire [3:0] out_data
);

localparam N = 4;

generate
    // In Verilog-2001, 'genvar i;' must explicitly declare the loop variable.
    // Omitting 'genvar' for 'i' is a Verilog-2005 feature (implicit genvar).
    // This construct will cause a syntax error (STX_VE_479) in Verilog-2001 mode.
    for (i = 0; i < N; i = i + 1) begin 
        assign out_data[i] = in_data[i];
    end
endgenerate

endmodule
