module curve_synth_5058_20260112_010456_429467_w37744_attempt13 (
    input wire [3:0] in1,
    input wire [3:0] in2,
    input wire [3:0] in3,
    input wire [3:0] in4,
    output wire       out_flag
);

    // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis
    // This module uses four distinct case equality comparisons to trigger the SYNTH_5058 rule four times.
    // The comparisons involve both input signals against constants and input signals against other input signals.

    wire condition1 = (in1 === 4'b1010); // Occurrence 1
    wire condition2 = (in2 === in1);    // Occurrence 2
    wire condition3 = (in3 === 4'b0101); // Occurrence 3
    wire condition4 = (in4 === in3);    // Occurrence 4

    assign out_flag = condition1 || condition2 || condition3 || condition4;

endmodule
