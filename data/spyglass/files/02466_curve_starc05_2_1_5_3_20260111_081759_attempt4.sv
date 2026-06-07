module curve_starc05_2_1_5_3_20260111_081759_attempt4 (
    input clk,
    input rst,
    input [1:0] data_in,
    input enable_processing,
    output reg [3:0] processed_output
);

reg [1:0] control_status; // A multi-bit signal intended to be used conditionally

always @(posedge clk or posedge rst) begin
    if (rst) begin
        control_status <= 2'b00;
        processed_output <= 4'h0;
    end else begin
        if (enable_processing) begin
            // Update control_status based on some logic, making it non-zero sometimes
            control_status <= data_in; // Assign data_in to make it dynamic
        end else begin
            control_status <= 2'b00;
        end

        // STARC05-2.1.5.3 violation: The conditional expression 'control_status'
        // is a multi-bit expression (2 bits wide). The rule flags that this
        // multi-bit expression does not evaluate to a scalar (1-bit value)
        // when used as a condition. Verilog implicitly converts it to a 1-bit boolean.
        processed_output <= control_status ? 4'hA : 4'h5; // Target line for STARC05-2.1.5.3
    end
end

endmodule
