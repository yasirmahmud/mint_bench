module aes_main_mux_42_32_1_1 #(
    parameter ID = 1,
    parameter NUM_STAGE = 1,
    parameter din0_WIDTH = 32,
    parameter din1_WIDTH = 32,
    parameter din2_WIDTH = 32,
    parameter din3_WIDTH = 32,
    parameter din4_WIDTH = 2,
    parameter dout_WIDTH = 32
) (
    input [din0_WIDTH-1:0] din0,
    input [din1_WIDTH-1:0] din1,
    input [din2_WIDTH-1:0] din2,
    input [din3_WIDTH-1:0] din3,
    input [din4_WIDTH-1:0] din4,
    output [dout_WIDTH-1:0] dout
);

reg [dout_WIDTH-1:0] dout_reg;

always @(*) begin
    case (din4)
        2'd0: dout_reg = din0;
        2'd1: dout_reg = din1;
        2'd2: dout_reg = din2;
        2'd3: dout_reg = din3;
        default: dout_reg = 'b0; // Default to 0 for unused select values
    endcase
end

assign dout = dout_reg;

endmodule
