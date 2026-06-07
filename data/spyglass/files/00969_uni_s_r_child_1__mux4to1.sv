module mux4to1 (
    input [3:0] in_bus,
    input [1:0] s,
    output reg out
);
    always @(*) begin
        case (s)
            2'b00: out = in_bus[0];
            2'b01: out = in_bus[1];
            2'b10: out = in_bus[2];
            2'b11: out = in_bus[3];
            default: out = 1'bx; // Should not happen for 2-bit select
        endcase
    end
endmodule
