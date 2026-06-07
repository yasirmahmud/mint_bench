module shift_register_32_stages (
    input CLK,
    input rst,
    input [15:0] din,
    output [15:0] Q1, output [15:0] Q2, output [15:0] Q3, output [15:0] Q4,
    output [15:0] Q5, output [15:0] Q6, output [15:0] Q7, output [15:0] Q8,
    output [15:0] Q9, output [15:0] Q10, output [15:0] Q11, output [15:0] Q12,
    output [15:0] Q13, output [15:0] Q14, output [15:0] Q15, output [15:0] Q16,
    output [15:0] Q17, output [15:0] Q18, output [15:0] Q19, output [15:0] Q20,
    output [15:0] Q21, output [15:0] Q22, output [15:0] Q23, output [15:0] Q24,
    output [15:0] Q25, output [15:0] Q26, output [15:0] Q27, output [15:0] Q28,
    output [15:0] Q29, output [15:0] Q30, output [15:0] Q31, output [15:0] Q32
);
    reg [15:0] s_reg [0:31];
    integer i;

    always @(posedge CLK or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                s_reg[i] <= 16'd0;
            end
        end else begin
            s_reg[0] <= din;
            for (i = 1; i < 32; i = i + 1) begin
                s_reg[i] <= s_reg[i-1];
            end
        end
    end

    assign Q1 = s_reg[0];
    assign Q2 = s_reg[1];
    assign Q3 = s_reg[2];
    assign Q4 = s_reg[3];
    assign Q5 = s_reg[4];
    assign Q6 = s_reg[5];
    assign Q7 = s_reg[6];
    assign Q8 = s_reg[7];
    assign Q9 = s_reg[8];
    assign Q10 = s_reg[9];
    assign Q11 = s_reg[10];
    assign Q12 = s_reg[11];
    assign Q13 = s_reg[12];
    assign Q14 = s_reg[13];
    assign Q15 = s_reg[14];
    assign Q16 = s_reg[15];
    assign Q17 = s_reg[16];
    assign Q18 = s_reg[17];
    assign Q19 = s_reg[18];
    assign Q20 = s_reg[19];
    assign Q21 = s_reg[20];
    assign Q22 = s_reg[21];
    assign Q23 = s_reg[22];
    assign Q24 = s_reg[23];
    assign Q25 = s_reg[24];
    assign Q26 = s_reg[25];
    assign Q27 = s_reg[26];
    assign Q28 = s_reg[27];
    assign Q29 = s_reg[28];
    assign Q30 = s_reg[29];
    assign Q31 = s_reg[30];
    assign Q32 = s_reg[31];
endmodule
