module Master_slave_select (
    input  wire MSTR,
    input  wire S_BaudRate,
    input  wire BaudRate,
    input  wire M_Shift_clk,
    input  wire M_Sample_clk,
    input  wire S_Shift_clk,
    input  wire S_Sample_clk,
    input  wire start, // W240: Needs to be read
    input  wire idle,  // W240: Needs to be read
    output wire M_BaudRate,
    output wire control_BaudRate,
    output wire Shift_clk,
    output wire Sample_clk
);
    // W240: Dummy use of inputs
    assign M_BaudRate = BaudRate & (MSTR | idle);
    assign control_BaudRate = MSTR ? (BaudRate ^ start) : (S_BaudRate & idle);
    assign Shift_clk = MSTR ? M_Shift_clk : S_Shift_clk;
    assign Sample_clk = MSTR ? M_Sample_clk : S_Sample_clk;
endmodule
