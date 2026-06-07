module top_module (
    input wire clk
);
    // Fix for SYNTH_132: Hierarchical references are not supported for synthesis.
    // Instead of using sub_inst.P1, define a local parameter in top_module
    // that holds the expected value of sub_module's P1 (which is 10).
    parameter SUB_MODULE_P1_VALUE = 10;

    sub_module sub_inst (.clk(clk));

    // Now, P2 can be calculated using the top-level parameter, avoiding hierarchical reference.
    localparam P2 = SUB_MODULE_P1_VALUE + 5;

    reg [P2-1:0] data;

    always @(posedge clk) begin
        data <= data + 1;
    end
endmodule
