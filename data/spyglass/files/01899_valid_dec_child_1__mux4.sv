// Definition for mux4 to resolve black-box errors (ID 13)
// Assumes 'sel' values 1, 2, 3 select in1, in2, in3 respectively, 
// and any other value (including 0) selects in0.
module mux4 (
    output reg out,
    input in0,
    input in1,
    input in2,
    input in3,
    input [3:0] sel
);
    always @(*) begin
        case (sel)
            4'd1: out = in1;
            4'd2: out = in2;
            4'd3: out = in3;
            default: out = in0;
        endcase
    end
endmodule
