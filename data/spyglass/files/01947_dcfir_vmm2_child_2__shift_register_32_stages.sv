// Helper module definition for shift_register_32_stages
module shift_register_32_stages (
    input CLK,
    input rst,
    input [15:0] din,
    output [15:0] Q1, Q2, Q3, Q4,
                  Q5, Q6, Q7, Q8,
                  Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16,
                  Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24,
                  Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32
);

reg [15:0] stages_reg[1:32]; // stages_reg[1] is output of first stage, etc.

always @(posedge CLK) begin
    integer i; // Declare integer loop variable outside for loop for Verilog-2001 compatibility
    if (rst) begin
        for (i = 1; i <= 32; i = i + 1) begin
            stages_reg[i] <= 16'd0;
        end
    end else begin
        stages_reg[1] <= din;
        for (i = 2; i <= 32; i = i + 1) begin
            stages_reg[i] <= stages_reg[i-1];
        end
    end
end

assign Q1 = stages_reg[1];
assign Q2 = stages_reg[2];
assign Q3 = stages_reg[3];
assign Q4 = stages_reg[4];
assign Q5 = stages_reg[5];
assign Q6 = stages_reg[6];
assign Q7 = stages_reg[7];
assign Q8 = stages_reg[8];
assign Q9 = stages_reg[9];
assign Q10 = stages_reg[10];
assign Q11 = stages_reg[11];
assign Q12 = stages_reg[12];
assign Q13 = stages_reg[13];
assign Q14 = stages_reg[14];
assign Q15 = stages_reg[15];
assign Q16 = stages_reg[16];
assign Q17 = stages_reg[17];
assign Q18 = stages_reg[18];
assign Q19 = stages_reg[19];
assign Q20 = stages_reg[20];
assign Q21 = stages_reg[21];
assign Q22 = stages_reg[22];
assign Q23 = stages_reg[23];
assign Q24 = stages_reg[24];
assign Q25 = stages_reg[25];
assign Q26 = stages_reg[26];
assign Q27 = stages_reg[27];
assign Q28 = stages_reg[28];
assign Q29 = stages_reg[29];
assign Q30 = stages_reg[30];
assign Q31 = stages_reg[31];
assign Q32 = stages_reg[32];

endmodule
