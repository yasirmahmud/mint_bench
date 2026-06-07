// Definition for mux8 to resolve black-box errors (ID 14)
// Assumes 'sel' values 1 through 6 select in1 through in6 respectively,
// and any other value (including 0 and >6) selects in0 (which is 1'b0).
module mux8 (
    output reg out,
    input in0,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    input [7:0] sel
);
    always @(*) begin
        case (sel)
            8'd1: out = in1;
            8'd2: out = in2;
            8'd3: out = in3;
            8'd4: out = in4;
            8'd5: out = in5;
            8'd6: out = in6;
            default: out = in0; // Covers sel=0, sel=7 (which is in7), and any other values
        endcase
    end
endmodule
