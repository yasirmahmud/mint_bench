// Add multiplication_normaliser module definition
module multiplication_normaliser (
    input [7:0] in_e,
    input [15:0] in_m,
    output reg [7:0] out_e,
    output reg [15:0] out_m
);

    reg [7:0] current_e;
    reg [15:0] current_m;
    integer i; // For loop counter, acceptable in combinational always block

    always @(*) begin
        current_e = in_e;
        current_m = in_m;

        // Perform left shifting until current_m[14] is 1 (normalized mantissa)
        // or the exponent becomes 0 (indicating denormalized/zero case).
        // The loop describes combinational logic.
        for (i = 0; i < 15; i = i + 1) begin // Max 15 shifts to bring any bit to position 14
            if (current_m[14] == 0 && current_e > 0) begin
                current_m = current_m << 1;
                current_e = current_e - 1;
            end else begin
                // If current_m[14] is 1 (normalized) or current_e is 0 (denormalized/underflow),
                // stop shifting to maintain functional behavior.
                break;
            end
        end

        out_e = current_e;
        out_m = current_m;
    end

endmodule
