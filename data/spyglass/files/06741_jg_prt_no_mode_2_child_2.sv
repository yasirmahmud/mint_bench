module test_no_mode_2 (
    input wire data_in,
    input wire clk,
    output wire data_out
);
    assign data_out = data_in;
    wire unused_clk;
    assign unused_clk = clk;
endmodule
