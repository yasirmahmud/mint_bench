/* Mux_register definition */
module Mux_register #(
    parameter No_of_bits = 1,
    parameter RSTTYPE = "SYNC", // or "ASYNC"
    parameter sel_en_reg = 1    // 1 for register, 0 for wire bypass
) (
    input [No_of_bits-1:0] Input,
    output reg [No_of_bits-1:0] Output,
    input clk,
    input EN,
    input rst
);

    generate
        if (sel_en_reg == 0) begin : gen_wire
            // When sel_en_reg is 0, the module acts as a direct combinatorial connection.
            // Output is driven by Input in an always_comb block.
            always @(*) begin
                Output = Input;
            end
            // FIX: Add dummy assignments to consume unused inputs when sel_en_reg is 0.
            // This resolves W240 "Input declared but not read" violations for clk, EN, rst.
            wire unused_clk_sink = clk;
            wire unused_en_sink = EN;
            wire unused_rst_sink = rst;
        end else begin : gen_register
            // Register behavior
            if (RSTTYPE == "SYNC") begin : gen_sync_reset
                always @(posedge clk) begin
                    if (rst) begin
                        Output <= {No_of_bits{1'b0}}; // Reset to 0
                    end else if (EN) begin
                        Output <= Input;
                    end
                end
            end else begin : gen_async_reset // Default to async if not SYNC (or unrecognized)
                always @(posedge clk or posedge rst) begin
                    if (rst) begin
                        Output <= {No_of_bits{1'b0}}; // Reset to 0
                    end else if (EN) begin
                        Output <= Input;
                    end
                end
            end
        end
    endgenerate

endmodule
