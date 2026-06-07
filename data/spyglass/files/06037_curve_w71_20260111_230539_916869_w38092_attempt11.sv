module curve_w71_20260111_230539_916869_w38092_attempt11 (
    input [2:0] sel,
    input [7:0] data_a,
    input [7:0] data_b,
    input [7:0] data_c,
    output reg [7:0] out_data
);

always @ (*) begin
    // W71 violation expected: 'out_data' is not assigned a default value
    // before the case statement within this combinational block, and the
    // case statement itself lacks a 'default' clause. The 3-bit 'sel'
    // has 8 possible values, but only 3 are covered, leading to an
    // incomplete assignment and an inferred latch.
    case (sel)
        3'b000: out_data = data_a;
        3'b001: out_data = data_b;
        3'b011: out_data = data_c;
        // Cases for 3'b010, 3'b100, 3'b101, 3'b110, 3'b111 are not covered.
    endcase
end

endmodule
