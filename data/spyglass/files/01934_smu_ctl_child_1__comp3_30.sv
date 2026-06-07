// Comparator: operand1 (3-bit) > operand2 (30-bit)
module comp3_30 (
    output reg result,
    input [2:0] operand1,  // e.g., 3'b110 (6), a positive limit
    input [29:0] operand2, // num_entries, potentially negative if signbit is true
    input signbit          // und_flw_bit: 1 for signed comparison (num_entries might be negative), 0 for unsigned
);
    // operand1 (limit) should typically be zero-extended as it's a positive threshold
    wire [29:0] extended_operand1 = {27'b0, operand1};
    
    always @(*) begin
        if (signbit) begin // num_entries is potentially negative, perform signed comparison
            result = ($signed(extended_operand1) > $signed(operand2));
        end else begin // num_entries is positive, perform unsigned comparison
            result = (extended_operand1 > operand2);
        end
    end
endmodule
