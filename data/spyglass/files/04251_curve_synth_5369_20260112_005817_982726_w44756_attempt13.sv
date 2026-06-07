module curve_synth_5369_20260112_005817_982726_w44756_attempt13 (
    input wire [7:0] data_in,
    output reg [31:0] result_out
);

    // Function to calculate a recursive sum.
    // The recursion depth can exceed 100 if data_in > 100.
    // This is intended to trigger SYNTH_5369.
    function [31:0] calculate_depth_sum;
        input [7:0] current_val;
        begin
            if (current_val == 1) begin
                calculate_depth_sum = 32'd1; // Base case for recursion
            end else if (current_val == 0) begin
                calculate_depth_sum = 32'd0; // Handle 0 explicitly to avoid infinite recursion or negative numbers
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                // due to the potential recursion depth exceeding 100 if current_val
                // is greater than 100.
                calculate_depth_sum = current_val + calculate_depth_sum(current_val - 1);
            end
        end
    endfunction

    always @(*) begin
        result_out = calculate_depth_sum(data_in);
    end

endmodule
