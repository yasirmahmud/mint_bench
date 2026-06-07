module expbot_dec(
    output [1:0] muxlimd, muxsad_a, muxsad_b, muxpaed_a, muxpaed_b, muxpaed_c, muxaed,
    output muxbed,
    input [3:0] ef,
    input [2:0] safunc,
    input topsign, movf, erop
);
    assign muxlimd = 2'b0;
    assign muxsad_a = 2'b0;
    assign muxsad_b = 2'b0;
    assign muxpaed_a = 2'b0;
    assign muxpaed_b = 2'b0;
    assign muxpaed_c = 2'b0;
    assign muxaed = 2'b0;
    assign muxbed = 1'b0;

    // Dummy assignment to consume unused inputs and resolve W240 violations
    wire _dummy_expbot_unused;
    assign _dummy_expbot_unused = |ef | |safunc | topsign | movf | erop;
endmodule
