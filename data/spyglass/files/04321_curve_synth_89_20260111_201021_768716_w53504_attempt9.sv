module curve_synth_89_20260111_201021_768716_w53504_attempt9 (
    input clk,
    input rst_n,
    output [1:0] out_state
);

    // SYNTH_89: Initial assignment at declaration for 'current_state' is ignored by synthesis.
    reg [1:0] current_state = 2'b01;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= 2'b00; // Reset value
        end else begin
            current_state <= current_state + 1;
        end
    end

    assign out_state = current_state;

endmodule
