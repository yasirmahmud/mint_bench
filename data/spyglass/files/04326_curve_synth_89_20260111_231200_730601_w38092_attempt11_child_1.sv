module curve_synth_89_20260111_231200_730601_w38092_attempt11 (
    input wire clk,
    input wire rst_n,
    output wire [2:0] out_val
);

    // SYNTH_89: Initial Assignment at Declaration for 'my_state' is ignored by synthesis.
    // The initial value '3'd5' will not be synthesized as a power-on reset value.
    reg [2:0] my_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            my_state <= 3'd0;
        end else begin
            my_state <= my_state + 3'd1;
        end
    }

    assign out_val = my_state;

endmodule
