module curve_wrn_27_20260112_005335_137375_w6680_attempt15 (
    input wire [1:0] data_in,
    input wire clk,
    input wire rst_n,
    output reg out1,
    output reg out2
);

    reg [1:0] internal_data_reg; // A 2-bit register (bits 0 and 1)

    // Drive internal_data_reg using sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            internal_data_reg <= 2'b00;
        end else begin
            internal_data_reg <= data_in;
        end
    end

    // WRN_27 violation 1: Bit-select 2 is out-of-range for a [1:0] register.
    // The register `internal_data_reg` has only bits 0 and 1.
    always @* begin
        out1 = internal_data_reg[2];
    end

    // WRN_27 violation 2: Bit-select 3 is out-of-range for a [1:0] register.
    // The register `internal_data_reg` has only bits 0 and 1.
    always @* begin
        out2 = internal_data_reg[3];
    end

endmodule
