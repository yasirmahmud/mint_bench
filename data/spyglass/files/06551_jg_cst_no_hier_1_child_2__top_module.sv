module top_module (
    input wire clk
);
    // Wire to connect the new output from sub_module
    wire [3:0] sub_dummy_out;
    sub_module sub_inst (.clk(clk), .dummy_out(sub_dummy_out)); // Connect the new output

    // This localparam definition originally used a hierarchical identifier in a constant expression (sub_inst.P1),
    // which is not supported for synthesis (SYNTH_132 error).
    // FIX for SYNTH_132: Replace the hierarchical reference with the explicit constant value of sub_module's P1.
    localparam ACTUAL_P1 = 10; // The value of sub_module's P1
    localparam P2 = ACTUAL_P1 + 5; // P2 will evaluate to 15, preserving original behavior

    reg [P2-1:0] data;

    always @(posedge clk) begin
        data <= data + 1;
    end
endmodule
