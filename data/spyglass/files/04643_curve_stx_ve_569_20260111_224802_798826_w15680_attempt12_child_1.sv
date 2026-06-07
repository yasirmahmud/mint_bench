module curve_stx_ve_569_20260111_224802_798826_w15680_attempt12 (
    input [1:0] sel,
    input       data_a,
    input       data_b,
    output reg  result
);

always @* begin
    case (sel)
        2'b00: begin
            result = data_a;
        end
        2'b01: begin
            result = data_b;
        end
    endcase
end
endmodule
