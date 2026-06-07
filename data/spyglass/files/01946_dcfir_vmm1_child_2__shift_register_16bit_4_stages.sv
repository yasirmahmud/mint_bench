// Stub for shift_register_16bit_4_stages
module shift_register_16bit_4_stages (
    input CLK,
    input Reset,
    input [15:0] din,
    output [15:0] Q1,
    output [15:0] Q2,
    output [15:0] Q3,
    output [15:0] Q4
);
    reg [15:0] stages[1:4];
    integer i;

    always @(posedge CLK or posedge Reset) begin
        if (Reset) begin
            for (i = 1; i <= 4; i = i + 1) begin
                stages[i] <= 16'd0;
            end
        end else begin
            for (i = 4; i > 1; i = i - 1) begin
                stages[i] <= stages[i-1];
            end
            stages[1] <= din;
        end
    end

    assign Q1 = stages[1];
    assign Q2 = stages[2];
    assign Q3 = stages[3];
    assign Q4 = stages[4];
endmodule
