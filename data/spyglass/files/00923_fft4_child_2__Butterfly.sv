module Butterfly #(
    parameter DATA_WIDTH = 8, // Input data width
    parameter EXPAND = 9      // Twiddle factor expansion (e.g., 9 for 1<<9 = 512)
)
(
    input wire clk,
    input wire rst_n,
    input wire en,

    input  wire signed [DATA_WIDTH-1:0] in1_real,
    input  wire signed [DATA_WIDTH-1:0] in1_imag,
    input  wire signed [DATA_WIDTH-1:0] in2_real,
    input  wire signed [DATA_WIDTH-1:0] in2_imag,

    // Twiddle factor is EXPAND+2 bits wide, as seen in RO_ARRAY in fft4 module
    input  wire signed [EXPAND+1:0] ro_real, 
    input  wire signed [EXPAND+1:0] ro_imag,

    // Output data width is DATA_WIDTH + 2 as per instantiation context in fft4
    output wire signed [DATA_WIDTH+1:0] out1_real,
    output wire signed [DATA_WIDTH+1:0] out1_imag,
    output wire signed [DATA_WIDTH+1:0] out2_real,
    output wire signed [DATA_WIDTH+1:0] out2_imag,

    output wire valid
);

    // Max bit width for product of (DATA_WIDTH bits) * (EXPAND+2 bits) is DATA_WIDTH + (EXPAND+2) - 1 = DATA_WIDTH + EXPAND + 1 bits.
    // We'll use DATA_WIDTH + EXPAND + 1 for registers to hold the full product (e.g., [DATA_WIDTH+EXPAND+1:0]).
    // Registers for pipeline stage 1: Complex multiplication results
    reg signed [DATA_WIDTH + EXPAND + 1 : 0] mult_real_r_reg;
    reg signed [DATA_WIDTH + EXPAND + 1 : 0] mult_imag_i_reg;
    reg signed [DATA_WIDTH + EXPAND + 1 : 0] mult_real_i_reg;
    reg signed [DATA_WIDTH + EXPAND + 1 : 0] mult_imag_r_reg;

    // Registers for pipelining input A (in1) for the next stage
    reg signed [DATA_WIDTH-1:0] in1_real_reg1, in1_imag_reg1;
    reg en_reg1; // Propagate enable signal

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mult_real_r_reg <= 0;
            mult_imag_i_reg <= 0;
            mult_real_i_reg <= 0;
            mult_imag_r_reg <= 0;
            in1_real_reg1 <= 0;
            in1_imag_reg1 <= 0;
            en_reg1 <= 1'b0;
        end else if (en) begin
            // Calculate components for B*W (in2_real + j*in2_imag) * (ro_real + j*ro_imag)
            // Real part: in2_real*ro_real - in2_imag*ro_imag
            // Imag part: in2_real*ro_imag + in2_imag*ro_real
            // WRN_1024 fixed: Removed redundant $signed() casts as operands are already signed.
            mult_real_r_reg <= in2_real * ro_real;
            mult_imag_i_reg <= in2_imag * ro_imag;
            mult_real_i_reg <= in2_real * ro_imag;
            mult_imag_r_reg <= in2_imag * ro_real;
            
            // Capture in1 for the next stage
            in1_real_reg1 <= in1_real;
            in1_imag_reg1 <= in1_imag;
            en_reg1 <= 1'b1; // Enable for next stage
        end else begin
            en_reg1 <= 1'b0; // If en is off, disable propagation
        end
    end

    // Intermediate sum/difference before shift, can require one extra bit for sum/diff
    // So, (DATA_WIDTH + EXPAND + 1) + 1 = DATA_WIDTH + EXPAND + 2 bits wide.
    wire signed [DATA_WIDTH + EXPAND + 2 : 0] sum_diff_products_real;
    wire signed [DATA_WIDTH + EXPAND + 2 : 0] sum_diff_products_imag;

    assign sum_diff_products_real = mult_real_r_reg - mult_imag_i_reg;
    assign sum_diff_products_imag = mult_real_i_reg + mult_imag_r_reg;

    // Stage 1 output: B*W calculation (shifted)
    // After shifting by EXPAND, the result width is (DATA_WIDTH + EXPAND + 2 - EXPAND) = DATA_WIDTH + 2 bits.
    wire signed [DATA_WIDTH + 1 : 0] bw_real_shifted;
    wire signed [DATA_WIDTH + 1 : 0] bw_imag_shifted;

    // W486 fixed: Explicitly slice the result of the arithmetic right shift to avoid width mismatch warning.
    assign bw_real_shifted = (sum_diff_products_real >>> EXPAND)[DATA_WIDTH+1:0]; // Arithmetic right shift
    assign bw_imag_shifted = (sum_diff_products_imag >>> EXPAND)[DATA_WIDTH+1:0]; // Arithmetic right shift

    // Registers for pipeline stage 2: Complex addition/subtraction
    // in1_real_reg2 and in1_imag_reg2 must be sign-extended to match bw_real_reg2/bw_imag_reg2 for correct addition.
    // Expected output width is DATA_WIDTH + 2 bits, so extend inputs to DATA_WIDTH + 2 bits.
    reg signed [DATA_WIDTH+1:0] in1_real_reg2;
    reg signed [DATA_WIDTH+1:0] in1_imag_reg2;
    reg signed [DATA_WIDTH+1:0] bw_real_reg2;
    reg signed [DATA_WIDTH+1:0] bw_imag_reg2;
    reg en_reg2; // Valid signal for stage 2

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            in1_real_reg2 <= 0;
            in1_imag_reg2 <= 0;
            bw_real_reg2 <= 0;
            bw_imag_reg2 <= 0;
            en_reg2 <= 1'b0;
        end else begin
            // Sign extend in1_real_reg1 from DATA_WIDTH bits to DATA_WIDTH+2 bits
            in1_real_reg2 <= {{2{in1_real_reg1[DATA_WIDTH-1]}}, in1_real_reg1};
            in1_imag_reg2 <= {{2{in1_imag_reg1[DATA_WIDTH-1]}}, in1_imag_reg1};
            bw_real_reg2 <= bw_real_shifted;
            bw_imag_reg2 <= bw_imag_shifted;
            en_reg2 <= en_reg1; // Propagate enable
        end
    end

    // Stage 2 outputs: A+B*W and A-B*W
    // The sum/difference of two (DATA_WIDTH+2)-bit numbers might require (DATA_WIDTH+3) bits.
    // However, the output ports are specified as (DATA_WIDTH+2) bits. Verilog will truncate
    // the result to fit the declared output width. This implies an assumption of no overflow
    // or a controlled truncation for the final output stage.
    assign out1_real = in1_real_reg2 + bw_real_reg2;
    assign out1_imag = in1_imag_reg2 + bw_imag_reg2;
    assign out2_real = in1_real_reg2 - bw_real_reg2;
    assign out2_imag = in1_imag_reg2 - bw_imag_reg2;
    assign valid = en_reg2; // Output valid when stage 2 has valid data

endmodule
