module curve_wrn_1021_20260112_004612_102327_w47152_attempt13 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] dummy_output
);

    // Declare a register array with a permissible range of [0:3]
    reg [7:0] data_storage[0:3];

    // The 'initial' block is replaced by an 'always' block with a reset condition
    // to resolve the SYNTH_5143 violation, ensuring synthesizable initialization.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Initialize data_storage elements on asynchronous reset
            data_storage[0] <= 8'h0A;
            // Fix WRN_1021: Array index 4 is out-of-bounds. Changed to valid index [1].
            data_storage[1] <= 8'hAA;
            // Fix WRN_1021: Array index 5 is out-of-bounds. Changed to valid index [2].
            data_storage[2] <= 8'hBB;
            // Initialize remaining array element to a known state
            data_storage[3] <= 8'h00;

            // Initialize dummy_output on reset to reflect the initial data_storage[0].
            dummy_output <= 8'h0A;
        end else begin
            // Assign a valid array element to the dummy register on clock edge.
            // dummy_output is made an output port to resolve W528 (set but not read).
            dummy_output <= data_storage[0];
        end
    end

endmodule
