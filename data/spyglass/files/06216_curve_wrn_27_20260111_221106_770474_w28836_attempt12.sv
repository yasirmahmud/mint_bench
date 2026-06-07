module curve_wrn_27_20260111_221106_770474_w28836_attempt12 (
    input wire clk,
    input wire rst_n,
    input wire [1:0] data_in,      // 2-bit input vector, valid indices 0, 1
    output reg valid_output,       // Output to consume a valid bit of data_vec
    output reg violation_output_a, // Output for first WRN_27 violation
    output reg violation_output_b  // Output for second WRN_27 violation
);

reg [1:0] data_vec; // 2-bit register, valid indices 0, 1

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_vec <= 2'b0;
        valid_output <= 1'b0;
        violation_output_a <= 1'b0;
        violation_output_b <= 1'b0;
    end else begin
        data_vec <= data_in; // data_vec is written, ensuring it is used.

        valid_output <= data_vec[0]; // Valid read from data_vec, to avoid W528 on data_vec itself.

        // WRN_27 violation 1: Bit-select 2 is out-of-range for a [1:0] vector.
        // Assigning to an output makes the result "used", avoiding W528 on the result.
        // This direct assignment is known to trigger SYNTH_5255 (Illegal bit select) and ErrorAnalyzeBBox in SpyGlass.
        violation_output_a <= data_vec[2];

        // WRN_27 violation 2: Bit-select 3 is out-of-range for a [1:0] vector.
        // Assigning to an output makes the result "used", avoiding W528 on the result.
        // This direct assignment is known to trigger SYNTH_5255 (Illegal bit select) and ErrorAnalyzeBBox in SpyGlass.
        violation_output_b <= data_vec[3];
    end
end

endmodule
