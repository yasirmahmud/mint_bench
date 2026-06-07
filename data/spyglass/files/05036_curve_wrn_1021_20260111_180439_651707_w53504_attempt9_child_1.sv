module curve_wrn_1021_20260111_180439_651707_w53504_attempt9 (
    input wire clk,
    input wire rst_n,
    input wire [3:0] user_index_a, // This can be 0-15
    input wire [3:0] user_index_b, // This can be 0-15
    input wire control_select,     // Selects which violation path
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    reg [7:0] my_array[0:9]; // Valid indices 0 to 9. Requires 4 bits to address 0-9.
    reg [7:0] my_array_next[0:9]; // Next state for my_array to resolve W415a

    reg [3:0] internal_index_counter; // A simple counter for valid access, 0-9
    reg [3:0] internal_index_counter_next; // Next state for internal_index_counter to resolve STARC05-2.11.3.1

    reg [4:0] potential_bad_index_a;  // Can hold values up to 31.
    reg [4:0] potential_bad_index_b;  // Can hold values up to 31.

    // Combinational logic for internal_index_counter_next to resolve STARC05-2.11.3.1
    always @(*) begin
        internal_index_counter_next = (internal_index_counter == 4'd9) ? 4'd0 : internal_index_counter + 4'd1;
    end

    // Combinational logic for my_array_next to resolve W415a violations
    always @(*) begin
        // Default to retaining current values for all elements
        for (integer i = 0; i < 10; i = i + 1) begin
            my_array_next[i] = my_array[i];
        end

        // Apply the primary write. This will be overwritten if the index matches a conditional write.
        // The indices here can cause WRN_1021 (array out-of-bounds access) but this is not a listed violation to fix.
        my_array_next[internal_index_counter] = data_in;

        // Apply the conditional writes. These will override my_array_next[internal_index_counter] if indices overlap.
        // The indices here can cause WRN_1021 (array out-of-bounds access) but this is not a listed violation to fix.
        if (control_select) begin
            my_array_next[potential_bad_index_a] = data_in + 8'd1;
        end else begin
            my_array_next[potential_bad_index_b] = data_in + 8'd2;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'd0;
            internal_index_counter <= 4'd0;
            potential_bad_index_a <= 5'd0;
            potential_bad_index_b <= 5'd0;
            // Initialize array elements to avoid uninitialized value warnings
            for (integer i = 0; i < 10; i = i + 1) begin
                my_array[i] <= 8'd0;
            end
        end else begin
            // Update internal_index_counter from its next state (resolves STARC05-2.11.3.1)
            internal_index_counter <= internal_index_counter_next;

            // Assign inputs to internal registers. user_index_a/b are [3:0], so potential_bad_index_a/b 
            // will take values from 0 to 15. The [4:0] width is just to accommodate potential values.
            potential_bad_index_a <= user_index_a;
            potential_bad_index_b <= user_index_b;

            // Update my_array from its next state. This is a single array assignment, resolving W415a.
            my_array <= my_array_next;

            // data_out reads the *current* state of my_array from the beginning of the cycle,
            // before the my_array <= my_array_next takes effect. This preserves original behavior.
            data_out <= my_array[internal_index_counter];
        end
    end

endmodule
