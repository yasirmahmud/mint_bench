// Butterfly module definition (resolves ErrorAnalyzeBBox violations)
module Butterfly #(
    parameter DATA_WIDTH = 8, // Input data width (e.g., in1_real, in2_real)
    parameter EXPAND = 9
)
(
    input wire clk,
    input wire rst_n,
    input wire en,

    input  wire signed [DATA_WIDTH-1:0] in1_real,
    input  wire signed [DATA_WIDTH-1:0] in1_imag,
    input  wire signed [DATA_WIDTH-1:0] in2_real,
    input  wire signed [DATA_WIDTH-1:0] in2_imag,

    input  wire signed [EXPAND+1:0] ro_real, // Twiddle factor real (e.g., RO_ARRAY[x][0])
    input  wire signed [EXPAND+1:0] ro_imag, // Twiddle factor imag (e.g., RO_ARRAY[x][1])

    output wire signed [DATA_WIDTH:0] out1_real, // Output width is DATA_WIDTH + 1
    output wire signed [DATA_WIDTH:0] out1_imag,
    output wire signed [DATA_WIDTH:0] out2_real,
    output wire signed [DATA_WIDTH:0] out2_imag,

    output reg valid
);
    // Width of twiddle factors from ifft4 module is EXPAND+2 bits ([EXPAND+1:0])
    localparam RO_INPUT_WIDTH = EXPAND + 2;

    // Product width for in2_real * ro_real. A signed N-bit number multiplied by a signed M-bit number
    // can result in N+M-1 bits. Using DATA_WIDTH + RO_INPUT_WIDTH - 1.
    localparam MULT_PRODUCT_WIDTH = DATA_WIDTH + RO_INPUT_WIDTH - 1;

    // Shifted product terms after division by 2^EXPAND.
    // The width becomes (MULT_PRODUCT_WIDTH - EXPAND) bits:
    // (DATA_WIDTH + RO_INPUT_WIDTH - 1) - EXPAND
    // = (DATA_WIDTH + (EXPAND+2) - 1) - EXPAND = DATA_WIDTH + 1 bits.
    localparam SHIFTED_PRODUCT_WIDTH = DATA_WIDTH + 1;

    // Sum/Difference terms: (DATA_WIDTH+1) bits +/- (DATA_WIDTH+1) bits.
    // This sum/difference could result in (DATA_WIDTH+1) + 1 = DATA_WIDTH+2 bits.
    localparam SUM_DIFFERENCE_WIDTH = DATA_WIDTH + 2;

    // Final output width for the module, as specified by ifft4 wiring.
    // The `in_real_step1` wires in ifft4 are `DATA_WIDTH+0:0`, which is `DATA_WIDTH+1` bits wide.
    localparam OUTPUT_ACTUAL_WIDTH = DATA_WIDTH + 1;


    // Pipelining registers for Stage 1: Complex multiplication
    // (in2_real + j*in2_imag) * (ro_real + j*ro_imag)
    // = (in2_real*ro_real - in2_imag*ro_imag) + j*(in2_real*ro_imag + in2_imag*ro_real)
    reg signed [MULT_PRODUCT_WIDTH-1:0] mult_rr_reg, mult_ii_reg, mult_ri_reg, mult_ir_reg;
    reg en_d1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mult_rr_reg <= 0;
            mult_ii_reg <= 0;
            mult_ri_reg <= 0;
            mult_ir_reg <= 0;
            en_d1 <= 1'b0;
        end else if (en) begin
            mult_rr_reg <= $signed(in2_real) * $signed(ro_real);
            mult_ii_reg <= $signed(in2_imag) * $signed(ro_imag);
            mult_ri_reg <= $signed(in2_real) * $signed(ro_imag);
            mult_ir_reg <= $signed(in2_imag) * $signed(ro_real);
            en_d1 <= 1'b1;
        end else begin
            en_d1 <= 1'b0;
        end
    end

    // Stage 2: Shift and combine complex product terms
    wire signed [SHIFTED_PRODUCT_WIDTH-1:0] shifted_rr, shifted_ii, shifted_ri, shifted_ir;
    assign shifted_rr = mult_rr_reg >>> EXPAND; 
    assign shifted_ii = mult_ii_reg >>> EXPAND;
    assign shifted_ri = mult_ri_reg >>> EXPAND;
    assign shifted_ir = mult_ir_reg >>> EXPAND;

    // Compute terms for butterfly
    // These intermediate terms will be SUM_DIFFERENCE_WIDTH = DATA_WIDTH+2 bits wide
    wire signed [SUM_DIFFERENCE_WIDTH-1:0] term_real_combined;
    wire signed [SUM_DIFFERENCE_WIDTH-1:0] term_imag_combined;
    assign term_real_combined = shifted_rr - shifted_ii;
    assign term_imag_combined = shifted_ri + shifted_ir;

    // Pipelining registers for in1 and combined terms
    reg signed [DATA_WIDTH-1:0] in1_real_d1, in1_imag_d1; // Pipeline in1 (original width)
    reg signed [SUM_DIFFERENCE_WIDTH-1:0] term_real_combined_d1, term_imag_combined_d1; // Pipelined terms
    reg en_d2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            in1_real_d1 <= 0;
            in1_imag_d1 <= 0;
            term_real_combined_d1 <= 0;
            term_imag_combined_d1 <= 0;
            en_d2 <= 1'b0;
        end else if (en_d1) begin
            in1_real_d1 <= in1_real; // Capture in1 from previous cycle
            in1_imag_d1 <= in1_imag;
            term_real_combined_d1 <= term_real_combined;
            term_imag_combined_d1 <= term_imag_combined;
            en_d2 <= 1'b1;
        end else begin
            en_d2 <= 1'b0;
        end
    end

    // Stage 3: Butterfly addition/subtraction
    // in1_real_d1 is DATA_WIDTH bits.
    // term_real_combined_d1 is DATA_WIDTH+2 bits.
    // Sum/difference of sign-extended in1_real_d1 (to DATA_WIDTH+2 bits) and term_real_combined_d1 (DATA_WIDTH+2 bits)
    // could potentially result in DATA_WIDTH+3 bits.
    // The output wire `outX_real_int` is `OUTPUT_ACTUAL_WIDTH` (DATA_WIDTH+1) bits wide.
    // Verilog implicitly truncates the MSBs if the assignment target is narrower, which matches
    // the required 1-bit growth per stage as indicated by the parent module's wire widths.
    wire signed [OUTPUT_ACTUAL_WIDTH-1:0] out1_real_int, out1_imag_int, out2_real_int, out2_imag_int;

    assign out1_real_int = $signed(in1_real_d1) + term_real_combined_d1;
    assign out1_imag_int = $signed(in1_imag_d1) + term_imag_combined_d1;
    assign out2_real_int = $signed(in1_real_d1) - term_real_combined_d1;
    assign out2_imag_int = $signed(in1_imag_d1) - term_imag_combined_d1;

    // Register the final outputs
    reg signed [OUTPUT_ACTUAL_WIDTH-1:0] out1_real_reg, out1_imag_reg, out2_real_reg, out2_imag_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out1_real_reg <= 0;
            out1_imag_reg <= 0;
            out2_real_reg <= 0;
            out2_imag_reg <= 0;
            valid <= 1'b0;
        end else if (en_d2) begin
            out1_real_reg <= out1_real_int;
            out1_imag_reg <= out1_imag_int;
            out2_real_reg <= out2_real_int;
            out2_imag_reg <= out2_imag_int;
            valid <= 1'b1;
        end else begin
            valid <= 1'b0;
        end
    end

    assign out1_real = out1_real_reg;
    assign out1_imag = out1_imag_reg;
    assign out2_real = out2_real_reg;
    assign out2_imag = out2_imag_reg;

endmodule
