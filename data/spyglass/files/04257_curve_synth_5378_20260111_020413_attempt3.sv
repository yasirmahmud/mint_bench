module curve_synth_5378_20260111_020413_attempt3 (
    input wire  clk_in_a,
    input wire  clk_in_b,
    input wire  clk_in_c,
    input wire  clk_in_d,
    input wire  clk_in_e,
    input wire  data_a,
    input wire  data_b,
    input wire  data_c,
    input wire  data_d,
    input wire  data_e,
    output reg  out_a,
    output reg  out_b,
    output reg  out_c,
    output reg  out_d,
    output reg  out_e
);

    // SYNTH_5378: Complex expression 'posedge (~clk_in_a)' is not allowed in event specification for synthesis
    // This triggers the SYNTH_5378 rule because '~clk_in_a' is a complex expression for event control.
    // By using an inversion of a single signal, we aim to avoid 'multiple clock' related violations (e.g., STARC05-2.3.3.1, W422)
    // that were triggered by using an OR combination of two distinct input signals in previous attempts.
    // This also avoids constant event expressions (like 'posedge 1') that can trigger W122/W218.
    always @(posedge (~clk_in_a)) begin
        out_a <= data_a;
    end

    always @(posedge (~clk_in_b)) begin
        out_b <= data_b;
    end

    always @(posedge (~clk_in_c)) begin
        out_c <= data_c;
    end

    always @(posedge (~clk_in_d)) begin
        out_d <= data_d;
    end

    always @(posedge (~clk_in_e)) begin
        out_e <= data_e;
    end

endmodule
