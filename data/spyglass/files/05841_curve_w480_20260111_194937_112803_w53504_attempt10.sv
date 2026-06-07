module curve_w480_20260111_194937_112803_w53504_attempt10 (
    input wire [5:0] input_bits,
    output reg xor_result
);

    // W480: Loop index 'idx_reg' is not of type integer.
    // Declaring 'idx_reg' as 'reg' instead of 'integer' causes the violation.
    reg [2:0] idx_reg; 

    always @(*) begin
        // Initialize xor_result to 0, which is the identity for XOR.
        xor_result = 1'b0; 
        
        // Loop over the input bits using 'idx_reg' which is a 'reg' type.
        // This 'for' loop using a 'reg' variable as index triggers W480.
        for (idx_reg = 3'd0; idx_reg < 3'd6; idx_reg = idx_reg + 3'd1) begin
            xor_result = xor_result ^ input_bits[idx_reg];
        end
    end

endmodule
