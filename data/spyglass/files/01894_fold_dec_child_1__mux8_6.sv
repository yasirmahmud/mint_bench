module mux8_6 (
    output [5:0] out,
    input [5:0] in0,
    input [5:0] in1,
    input [5:0] in2,
    input [5:0] in3,
    input [5:0] in4,
    input [5:0] in5,
    input [5:0] in6,
    input [5:0] in7,
    input [7:0] sel
);
    // Dummy definition to resolve black-box violation.
    // Implements an 8-to-1 multiplexer using the lower 3 bits of 'sel'.
    always @(*) begin
        case(sel[2:0])
            3'd0: out = in0;
            3'd1: out = in1;
            3'd2: out = in2;
            3'd3: out = in3;
            3'd4: out = in4;
            3'd5: out = in5;
            3'd6: out = in6;
            3'd7: out = in7;
            default: out = in0; // Should not be reached with 3-bit select
        endcase
    end
endmodule
