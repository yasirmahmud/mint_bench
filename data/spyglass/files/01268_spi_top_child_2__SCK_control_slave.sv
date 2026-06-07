module SCK_control_slave (
    input  wire SCK_in,
    input  wire CPOL,
    input  wire CPHA,
    input  wire idle,
    output wire S_BaudRate,
    output wire Shift_clk,
    output wire Sample_clk
);
    // W240: Dummy use of inputs
    assign S_BaudRate = SCK_in & CPOL & CPHA & idle;
    assign Shift_clk = SCK_in | CPOL;
    assign Sample_clk = CPHA | idle;
endmodule
