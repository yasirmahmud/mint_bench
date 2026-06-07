// Comparator: operand1 (6-bit) > operand2 (30-bit)
module comp6_30 (
    output reg result,
    input [5:0] operand1, // high_mark or 6'b111011 (59), positive limits
    input [29:0] operand2, // num_entries, potentially negative if signbit is true
    input signbit          // und_flw_bit
);
    // operand1 (limit) should typically be zero-extended
    wire [29:0] extended_operand1 = {24'b0, operand1};
    
    always @(*) begin
        if (signbit) begin // num_entries is potentially negative, perform signed comparison
            result = ($signed(extended_operand1) > $signed(operand2));
        end else begin // num_entries is positive, perform unsigned comparison
            result = (extended_operand1 > operand2);
        end
    end
endmodule
