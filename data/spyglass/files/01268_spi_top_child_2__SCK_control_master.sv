module SCK_control_master (
    input  wire M_BaudRate,
    input  wire CPOL,
    input  wire CPHA,
    input  wire idle,
    output wire SCK_out,
    output wire Shift_clk,
    output wire Sample_clk
);
    // W240: Dummy use of inputs
    assign SCK_out = M_BaudRate & CPOL & CPHA & idle;
    assign Shift_clk = M_BaudRate | CPOL;
    assign Sample_clk = CPHA | idle;
endmodule
