module multmod_cntl (
    output [17:0] nx_multdec_muxcntl,
    input  [3:0] nx_multfunc_rom0,
    input  [3:0] nx_multfunc_rom1,
    input  [1:0] romsel,
    input  nx_cyc0_rdy,
    input  clk,
    input  reset_l
);
    // Dummy assignment
    assign nx_multdec_muxcntl = 18'b0;
endmodule
