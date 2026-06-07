module lint_starc02_2_10_3_5_ex1 (
    input clk,
    input rst_n,
    output reg [7:0] data
);

// Original behavior: 'data' is initialized to 42 once at the start.
// This is replaced by a synthesizable asynchronous reset to 42.
// The 'data' register is also made an output to resolve the 'set but not read' warning.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data <= 8'd42;
    end
    // In this specific example, since no other logic updates 'data',
    // it will effectively hold the value 42 after the reset is deasserted.
end

endmodule
