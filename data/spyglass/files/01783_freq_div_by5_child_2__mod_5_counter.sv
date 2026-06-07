module mod_5_counter(
    input clk, reset,
    output reg [2:0] q
    );

    wire [2:0] q_next; // Wire for the next state of q

    // Combinational logic to determine the next state
    always_comb begin
        if (q == 3'd4) begin // Counts 0, 1, 2, 3, 4
            q_next = 3'd0;
        end else begin
            q_next = q + 3'd1;
        end
    end

    // Sequential logic for the register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 3'd0;
        end else begin
            q <= q_next; // Update q with the calculated next state
        end
    end

endmodule
