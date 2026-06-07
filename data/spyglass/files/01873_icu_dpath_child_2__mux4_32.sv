// -----------------------------------------------------------------
// Stub module definitions to resolve ErrorAnalyzeBBox violations
// -----------------------------------------------------------------

module mux4_32 (
    output [31:0] out,
    input  [31:0] in0,
    input  [31:0] in1,
    input  [31:0] in2,
    input  [31:0] in3,
    input  [3:0]  sel
);
    assign out = (sel==4'd0) ? in0 : 
                 (sel==4'd1) ? in1 : 
                 (sel==4'd2) ? in2 : in3;
endmodule
