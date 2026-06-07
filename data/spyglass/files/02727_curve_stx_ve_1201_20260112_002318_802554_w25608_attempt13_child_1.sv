module curve_stx_ve_1201_20260112_002318_802554_w25608_attempt13 (
    input clk,
    input reset,
    input [7:0] in_data,
    output reg [7:0] out_data_1,
    output reg [7:0] out_data_2
);

    // First violation: Mismatched begin/end label within an 'if' branch inside an always block
    always @(posedge clk or posedge reset) begin : main_seq_block_start
        if (reset) begin : reset_path_begin
            out_data_1 <= 8'h00;
        end : reset_path_begin // STX_VE_1201: 'reset_path_begin' vs 'reset_path_end_mismatch' - FIXED
        else begin : data_path_begin
            out_data_1 <= in_data;
        end : data_path_begin // This block's labels match
    end : main_seq_block_start // This block's labels match

    // Second violation: Mismatched begin/end label within a task definition
    task calculate_sum_task;
        input [7:0] arg_a;
        input [7:0] arg_b;
        output reg [7:0] sum_out;
        begin : task_body_start_label
            sum_out = arg_a + arg_b;
        end : task_body_start_label // STX_VE_1201: 'task_body_start_label' vs 'task_body_end_mismatch' - FIXED
    endtask

    // Instantiate and use the task to avoid unused signals
    always @(posedge clk) begin : task_instantiation_block
        reg [7:0] internal_reg;
        if (reset) begin
            internal_reg <= 8'h00;
            out_data_2 <= 8'h00;
        end else begin
            internal_reg <= in_data;
            calculate_sum_task(internal_reg, 8'd5, out_data_2);
        end
    end : task_instantiation_block // This block's labels match

endmodule
