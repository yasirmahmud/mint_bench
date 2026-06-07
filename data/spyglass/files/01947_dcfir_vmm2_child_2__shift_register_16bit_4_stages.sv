// Helper module definition for shift_register_16bit_4_stages
module shift_register_16bit_4_stages (
    input CLK,
    input Reset, // Note: input name 'Reset' as per instantiation
    input [15:0] din,
    output [15:0] Q1, Q2, Q3, Q4
);

reg [15:0] stages_reg[1:4]; // stages_reg[1] is output of first stage, etc.

always @(posedge CLK) begin
    if (Reset) begin
        stages_reg[1] <= 16'd0;
        stages_reg[2] <= 16'd0;
        stages_reg[3] <= 16'd0;
        stages_reg[4] <= 16'd0;
    end else begin
        stages_reg[1] <= din;
        stages_reg[2] <= stages_reg[1];
        stages_reg[3] <= stages_reg[2];
        stages_reg[4] <= stages_reg[3];
    end
end

assign Q1 = stages_reg[1];
assign Q2 = stages_reg[2];
assign Q3 = stages_reg[3];
assign Q4 = stages_reg[4];

endmodule
