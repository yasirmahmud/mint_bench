module shift_register_16bit_4_stages (
    input CLK,
    input Reset,
    input [15:0] din,
    output [15:0] Q1,
    output [15:0] Q2,
    output [15:0] Q3,
    output [15:0] Q4
);
    reg [15:0] s_reg [0:3];
    integer i;

    always @(posedge CLK or posedge Reset) begin
        if (Reset) begin
            for (i = 0; i < 4; i = i + 1) begin
                s_reg[i] <= 16'd0;
            end
        end else begin
            s_reg[0] <= din;
            for (i = 1; i < 4; i = i + 1) begin
                s_reg[i] <= s_reg[i-1];
            end
        end
    end

    assign Q1 = s_reg[0];
    assign Q2 = s_reg[1];
    assign Q3 = s_reg[2];
    assign Q4 = s_reg[3];
endmodule
