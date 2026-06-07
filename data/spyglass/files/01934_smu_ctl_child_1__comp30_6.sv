// Comparator: operand1 (30-bit) > operand2 (6-bit)
module comp30_6 (
    output reg result,
    input [29:0] operand1, // num_entries, potentially negative if signbit is true
    input [5:0] operand2,  // low_mark, a positive limit
    input signbit          // und_flw_bit
);
    // operand2 (limit) should typically be zero-extended
    wire [29:0] extended_operand2 = {24'b0, operand2};

    always @(*) begin
        if (signbit) begin // num_entries is potentially negative, perform signed comparison
            result = ($signed(operand1) > $signed(extended_operand2));
        end else begin // num_entries is positive, perform unsigned comparison
            result = (operand1 > extended_operand2);
        end
    end
endmodule
