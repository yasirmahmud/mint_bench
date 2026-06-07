// pri_encode
module pri_encode(
    output [5:0] out,
    input  [31:0] in
);
    integer i;
    always @* begin
        out = 6'd0; // Default: if no bit is set, output 0
        for (i = 0; i < 32; i = i + 1) begin
            if (in[31-i] == 1'b1) begin
                out = 6'd31 - i; // Position of MSB set (0-31)
                break;
            end
        end
    end
endmodule
