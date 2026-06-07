module curve_synth_89_20260111_231200_730601_w38092_attempt12 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);

    // SYNTH_89: Initial assignment at declaration for 'data_register' is ignored by synthesis.
    // The initial value 8'hFF will not be synthesized as a power-on reset value.
    reg [7:0] data_register = 8'hFF;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_register <= 8'h00; // Reset value
        end else begin
            data_register <= data_in; // Normal operation
        end
    end

    assign data_out = data_register;

endmodule
