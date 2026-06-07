// SubModule definition to resolve ErrorAnalyzeBBox violation.
// This module implements a single pipelined FFT butterfly operation.
// Inputs xp, xq are processed with a twiddle factor W (factor_real, factor_imag).
// Outputs yp, yq are registered versions of the butterfly results.
// The enable signal 'en' is pipelined to 'valid'.
module SubModule (
    input                    clk,
    input                    rstn,
    input                    en,

    input signed [23:0]      xp_real,
    input signed [23:0]      xp_imag,
    input signed [23:0]      xq_real,
    input signed [23:0]      xq_imag,

    input signed [15:0]      factor_real,
    input signed [15:0]      factor_imag,

    output reg               valid,
    output reg signed [23:0] yp_real,
    output reg signed [23:0] yp_imag,
    output reg signed [23:0] yq_real,
    output reg signed [23:0] yq_imag
);

    // Intermediate wires for complex multiplication (W * Q)
    // Assuming 'factor' is Q13 and 'xq' is Q15, the product is Q28.
    // Result needs to be scaled back to Q15 for addition with 'xp'.
    // Product width: 16-bit * 24-bit = 40-bit.
    wire signed [39:0]       prod_rr, prod_ii, prod_ri, prod_ir;
    wire signed [23:0]       w_times_q_real_s, w_times_q_imag_s; // scaled product

    // Complex multiplication W * Q: (Wr + jWi) * (Qr + jQi) = (Wr*Qr - Wi*Qi) + j*(Wr*Qi + Wi*Qr)
    assign prod_rr = factor_real * xq_real;
    assign prod_ii = factor_imag * xq_imag;
    assign prod_ri = factor_real * xq_imag;
    assign prod_ir = factor_imag * xq_real;

    // Scale down the product. Shift right by (Q_factor + Q_data - Q_output_data) = (13 + 15 - 15) = 13 bits.
    assign w_times_q_real_s = (prod_rr - prod_ii) >> 13; // Verilog '>>' is arithmetic shift for signed types
    assign w_times_q_imag_s = (prod_ri + prod_ir) >> 13; // Verilog '>>' is arithmetic shift for signed types

    // Pipelined Butterfly operation:
    // yp = xp + W*xq
    // yq = xp - W*xq
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            valid   <= 1'b0;
            yp_real <= 0;
            yp_imag <= 0;
            yq_real <= 0;
            yq_imag <= 0;
        end else if (en) begin // Changed '{' to 'begin'
            valid   <= 1'b1; // Propagate enable as valid
            yp_real <= xp_real + w_times_q_real_s;
            yp_imag <= xp_imag + w_times_q_imag_s;
            yq_real <= xp_real - w_times_q_real_s;
            yq_imag <= xp_imag - w_times_q_imag_s;
        end else begin // Changed '}' to 'end' and '{' to 'begin'
            // When not enabled, pipeline should ideally pass 'not valid' and zero out data
            valid   <= 1'b0;
            yp_real <= 0;
            yp_imag <= 0;
            yq_real <= 0;
            yq_imag <= 0;
        end // Changed '}' to 'end'
    end

endmodule
