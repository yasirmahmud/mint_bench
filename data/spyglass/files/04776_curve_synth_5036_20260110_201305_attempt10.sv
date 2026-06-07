module curve_synth_5036_20260110_201305_attempt10 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output wire [7:0] result_a,
    output reg [7:0] result_b
);

    // Task 1: Contains a non-blocking assignment to an output argument.
    // SYNTH_5036 is expected here because it's a non-blocking assignment
    // in a subprogram (task) that synthesis will treat as blocking. WRN_44 is
    // avoided because its description specifically targets non-blocking assignments in *functions*.
    task calculate_value (
        input [7:0] val_in,
        output [7:0] out_val
    );
        begin
            out_val <= val_in + 8'd3; // Violation 1 for SYNTH_5036
        end
    endtask

    // Task 2: Another instance of a non-blocking assignment to an output
    // argument in a task, to generate the second SYNTH_5036 violation.
    task increment_value (
        input [7:0] current_val,
        output [7:0] next_val
    );
        begin
            next_val <= current_val + 8'd1; // Violation 2 for SYNTH_5036
        end
    endtask

    // Use Task 1 in a combinational context. The task call itself is blocking.
    // The non-blocking assignment within the task will be treated as blocking by synthesis.
    wire [7:0] temp_result_calc;
    always @(*) begin
        calculate_value(data_in_a, temp_result_calc);
    end
    assign result_a = temp_result_calc;

    // Use Task 2 in a sequential context. The task call itself is blocking.
    // The non-blocking assignment within the task will be treated as blocking by synthesis.
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            result_b <= 8'h00;
        end else begin
            increment_value(data_in_b, result_b);
        end
    end

endmodule
