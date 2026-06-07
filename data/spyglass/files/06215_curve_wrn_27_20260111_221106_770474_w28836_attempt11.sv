module curve_wrn_27_20260111_221106_770474_w28836_attempt11 (
    input wire clk,
    input wire rst_n,
    input wire [2:0] data_in,
    output reg out1,
    output reg out2
);

reg [2:0] my_internal_reg; // Declared as 3 bits, valid indices are 0, 1, 2

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        my_internal_reg <= 3'b000;
        out1 <= 1'b0;
        out2 <= 1'b0;
    end else begin
        // The input data_in is used to drive my_internal_reg to prevent optimization
        // and ensure my_internal_reg is a live signal.
        my_internal_reg <= data_in;

        // WRN_27 violation 1: Bit-select 3 is out-of-range for a [2:0] register.
        // Assigning to an output to ensure the violation is captured by SpyGlass.
        out1 <= my_internal_reg[3];

        // WRN_27 violation 2: Bit-select 4 is out-of-range for a [2:0] register.
        // Assigning to an output to ensure the violation is captured by SpyGlass.
        out2 <= my_internal_reg[4];
    end
end

endmodule
