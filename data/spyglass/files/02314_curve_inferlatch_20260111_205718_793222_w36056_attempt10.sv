module curve_inferlatch_20260111_205718_793222_w36056_attempt10 (
    input wire enable_i,
    input wire [3:0] data_i,
    output reg [3:0] q_o
);

// A latch is inferred for 'q_o' because it is not assigned a value
// under all possible conditions within the combinational always block.
// Specifically, when 'enable_i' is low, 'q_o' retains its previous value,
// thus inferring a latch.
always @(enable_i or data_i) begin
    if (enable_i) begin
        q_o = data_i;
    end
    // No else branch for q_o means it holds its value when enable_i is 0.
end

endmodule
