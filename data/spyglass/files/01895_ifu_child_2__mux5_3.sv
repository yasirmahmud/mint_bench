// Special mux_5_3 to handle flag-based selection, not log2-encoded
module mux5_3 (
    output [2:0] out,
    input [2:0] in0, input [2:0] in1, input [2:0] in2, input [2:0] in3, input [2:0] in4,
    input [4:0] sel // This is a flag vector to select the output
);
    reg [2:0] r_out;
    always @(*) begin
        if (sel[4]) r_out = in4;       // Corresponds to fold_4_inst
        else if (sel[3]) r_out = in3;  // Corresponds to fold_3_inst
        else if (sel[2]) r_out = in2;  // Corresponds to fold_2_inst
        else if (sel[1]) r_out = in1;  // Corresponds to fold_1_inst
        else if (sel[0]) r_out = in0;  // Corresponds to not_valid
        else r_out = 3'b0; // Default if no flags are set
    end
    assign out = r_out;
endmodule
