module adder_16bit(
    input CLK,
    input Reset,
    input signed [15:0] input_a,
    input signed [15:0] input_b,
    output reg signed [15:0] output_z
);

    always @(posedge CLK or posedge Reset) begin
        if (Reset) begin
            output_z <= 16'd0;
        end else begin
            // Sum of two 16-bit signed numbers. The result can be 17-bit.
            // Truncate to 16-bit as per output port width.
            output_z <= (input_a + input_b)[15:0];
        end
    end

endmodule
