module curve_stx_ve_479_20260111_145104_attempt12 (
    input wire clk
);

localparam N = 2;
genvar i;

generate
    // STX_VE_479: In Verilog-2001, a 'generate for' loop that uses a 'begin...end'
    // block to enclose its generate items requires that block to be explicitly named
    // (e.g., 'begin : loop_name'). The use of an unnamed 'begin' block in this context
    // is a Verilog-2005 or SystemVerilog feature. When parsed strictly as Verilog-2001,
    // this construct triggers STX_VE_479, indicating a syntax error due to the missing
    // block identifier. The error often points to the 'begin' keyword or the closing 'end'.
    for (i = 0; i < N; i = i + 1) begin
        wire [7:0] data_temp;
        assign data_temp = i + 8'd1;
    end
endgenerate

endmodule
