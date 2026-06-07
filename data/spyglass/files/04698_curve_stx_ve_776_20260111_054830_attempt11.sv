module curve_stx_ve_776_20260111_054830_attempt11 (
    input wire clk,
    output reg out_data
);

    // According to IEEE Std 1364-2001, Section 9.2, 'always' statements
    // cannot be declared within an 'initial' statement. An 'initial' block
    // defines a procedural scope, whereas 'always' is a concurrent procedural statement
    // that must be declared at the module level or within a generate block.
    initial begin
        // This 'always' block is placed illegally within an 'initial' block's procedural scope.
        always @(posedge clk) begin // <-- This line is expected to trigger STX_VE_776
            out_data <= 1'b0;
        end
    end

endmodule
