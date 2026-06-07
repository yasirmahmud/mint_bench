module star_c02_2_1_6_5_ex1 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] arr_data_out
);
    reg [7:0] arr[0:3];
    reg [1:0] idx;

    // The initial block is converted to a synthesizable always block with a reset condition.
    // This resolves SYNTH_5143 (initial block ignored for synthesis).
    // The assignment of 'x' to idx is removed and replaced with a concrete value (2'b0).
    // This resolves NoAssignX-ML (RHS of the assignment contains 'X').
    // An output 'arr_data_out' is added to read from 'arr', resolving W528 (variable 'arr' set but not read).
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            idx <= 2'b0;        // Replaced 2'b1x with a concrete value for synthesizability
            arr[0] <= 8'b0;     // Initializes arr[0] at reset, mimicking the original one-time write with idx = 2'b0
            arr[1] <= 8'h0;
            arr[2] <= 8'h0;
            arr[3] <= 8'h0;
            arr_data_out <= 8'h0;
        end else begin
            // In the post-reset state, 'idx' continues to hold a concrete value.
            // We ensure 'arr' is read to satisfy the W528 rule.
            idx <= 2'b0;
            arr_data_out <= arr[idx]; // Read from arr to fix W528
        end
    end

endmodule
