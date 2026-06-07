module curve_wrn_27_20260111_180650_632719_w7792_attempt8 (
    input clk,
    input rst_n,
    input [7:0] i_data,
    output reg o_valid_bit,
    output reg o_other_valid_bit
);

reg [7:0] internal_data_reg;
reg out_of_range_reg1;
reg out_of_range_reg2;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        internal_data_reg <= 8'h00;
        o_valid_bit       <= 1'b0;
        out_of_range_reg1 <= 1'b0;
        out_of_range_reg2 <= 1'b0;
        o_other_valid_bit <= 1'b0;
    end else begin
        // Assign input to internal register, ensuring i_data is used
        internal_data_reg <= i_data;

        // Assign a valid bit to an output, ensuring internal_data_reg is read within its valid range
        o_valid_bit <= internal_data_reg[0];
        o_other_valid_bit <= internal_data_reg[1];

        // WRN_27 violation 1: Bit-select 8 is out-of-range for a [7:0] register
        // This assignment is to an internal register that is not a module output.
        // The intent is for SpyGlass to report WRN_27, but for synthesis tools
        // to potentially optimize away this unused logic and thus avoid SYNTH_5255.
        out_of_range_reg1 <= internal_data_reg[8];

        // WRN_27 violation 2: Bit-select 9 is out-of-range for a [7:0] register
        // Similar to the first violation, assigned to an internal, unused register.
        out_of_range_reg2 <= internal_data_reg[9];
    end
end

endmodule
