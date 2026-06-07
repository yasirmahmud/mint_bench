module curve_flopclockconstant_20260112_003115_514522_w44756_attempt14 (
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output reg [7:0] q_out_a,
    output reg [7:0] q_out_b
);

    // Declare wires that will serve as the constant '0' clock sources.
    wire clkg_flop_a;
    wire clkg_flop_b;

    // Assign these wires to a constant logic '0'.
    // This creates the condition for a FlopClockConstant violation, as the clock
    // input to the inferred flip-flops will be tied low.
    assign clkg_flop_a = 1'b0;
    assign clkg_flop_b = 1'b0;

    // First always block: infers a flip-flop clocked by 'clkg_flop_a'.
    // Since 'clkg_flop_a' is tied to '0', this triggers the first FlopClockConstant violation.
    always @(posedge clkg_flop_a) begin
        q_out_a <= data_in_a;
    end

    // Second always block: infers another flip-flop clocked by 'clkg_flop_b'.
    // Since 'clkg_flop_b' is also tied to '0', this triggers the second FlopClockConstant violation,
    // fulfilling the requirement for 2 total occurrences.
    always @(posedge clkg_flop_b) begin
        q_out_b <= data_in_b;
    end

endmodule
