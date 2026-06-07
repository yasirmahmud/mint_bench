module curve_w480_20260111_194937_112803_w53504_attempt8 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] final_sum
);

    // W480: Loop index 'idx' is declared as 'reg' instead of 'integer'.
    // This declaration directly triggers the target rule.
    reg [3:0] idx; 

    // 'temp_combinational_result' is a module-level 'reg' used as a temporary
    // for combinational calculation within the 'always @(*)' block.
    // It is exclusively assigned using blocking assignments in this block
    // and is always assigned to prevent latches, thus avoiding W505, SYNTH_77, W415a, etc.
    reg [7:0] temp_combinational_result;

    // Combinational block to calculate the sum. The loop uses the 'reg' type index 'idx'.
    always @(*) begin
        // Initialize the temporary result for the current combinational evaluation.
        temp_combinational_result = 8'h0;

        // The loop index 'idx' is of type 'reg', which violates W480.
        for (idx = 4'd0; idx < 4'd3; idx = idx + 4'd1) begin
            temp_combinational_result = temp_combinational_result + 8'd1;
        end
    end

    // Sequential block to register the final sum at the positive edge of the clock.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            final_sum <= 8'h00; // Reset output on active-low reset
        end else begin
            final_sum <= temp_combinational_result; // Register the combinational result
        end
    end

endmodule
