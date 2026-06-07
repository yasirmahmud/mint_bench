module curve_starc05_2_1_5_3_20260111_081759_attempt3 (
    input clk,
    input rst,
    input [3:0] input_data,
    input enable_counter,
    output reg [3:0] status_output
);

reg [3:0] current_count; // Multi-bit signal, similar to 'count' in rule description
reg [3:0] previous_data;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_count <= 4'h0;
        previous_data <= 4'h0;
        status_output <= 4'h0;
    end else begin
        if (enable_counter) begin
            current_count <= current_count + 1;
        end else begin
            current_count <= 4'h0;
        end
        previous_data <= input_data;

        // STARC05-2.1.5.3 violation:
        // The conditional expression (current_count + previous_data) is a multi-bit expression (up to 5 bits wide).
        // The rule flags that this multi-bit expression does not evaluate to a scalar when used as a condition.
        // Verilog implicitly converts multi-bit conditions to a 1-bit boolean (0 if all bits are 0, 1 otherwise).
        status_output <= (current_count + previous_data) ? input_data : 4'h0; // Target line for STARC05-2.1.5.3
    end
end

endmodule
