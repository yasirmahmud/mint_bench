module curve_synth_89_20260111_231200_730601_w38092_attempt12 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);

    // The initial assignment to 'data_register' is removed as it's ignored by synthesis
    // and the reset logic already defines the power-on/reset state.
    reg [7:0] data_register;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_register <= 8'h00; // Reset value
        end else begin
            data_register <= data_in; // Normal operation
        end
    }

    assign data_out = data_register;

endmodule
