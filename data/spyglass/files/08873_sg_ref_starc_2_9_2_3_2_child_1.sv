module starc_2_9_2_3_ex2 (
    input [7:0] data_array [0:11],
    output reg flag
);

integer i;

// The logic from the initial block is moved to an always_comb block for synthesis.
// flag becomes an output, and data_array becomes an input to resolve violations.
always @* begin
    flag = 1'b0; // Default to 0
    for (i = 0; i <= 11; i = i + 1) begin
        if (data_array[i] == 8'hA) begin
            flag = 1'b1; // Set flag to 1 if any element matches
        end
    end
end

endmodule
