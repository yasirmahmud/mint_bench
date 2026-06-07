// Definition for pipe_reg to resolve black-box violation (ELAB_3519)
// This module implements the behavior derived from the commented-out pre_data and pre_vld always blocks
// in the parent module, matching the inputs/outputs used in its instantiation.
module pipe_reg #(
    parameter DSIZE = 8
) (
    input                 clock,
    input                 rst_n,
    input                 wr_en,       // Corresponds to send_valid
    input  [DSIZE-1:0]    indata,      // Corresponds to send_data
    input                 low_empty,   // Corresponds to reload
    output                valid,       // Corresponds to pre_vld
    output                curr_empty,  // Corresponds to !pre_vld (or some empty state)
    output                sum_empty,   // Not connected in parent, tie to 1'b0
    output [DSIZE-1:0]    outdata,     // Corresponds to pre_data
    output                high_reload  // Not connected in parent, tie to 1'b0
);

reg [DSIZE-1:0]   pre_data_reg;
reg               pre_vld_reg;

// Implements `pre_data <= send_valid? send_data : pre_data;` (from commented code, excluding `idle` effect as `idle` is not an input)
always @(posedge clock, negedge rst_n) begin
    if (~rst_n) begin
        pre_data_reg <= {DSIZE{1'b0}};
    end else begin
        pre_data_reg <= wr_en ? indata : pre_data_reg;
    end
end

// Implements `if(send_valid) pre_vld <= reload; else if(reload) pre_vld <= 1'b0;` (from commented code)
always @(posedge clock, negedge rst_n) begin
    if (~rst_n) begin
        pre_vld_reg <= 1'b0;
    end else begin
        if (wr_en) begin
            pre_vld_reg <= low_empty;
        end else if (low_empty) begin
            pre_vld_reg <= 1'b0;
        }
        // else pre_vld_reg <= pre_vld_reg; (implied by no change)
    end
end

assign outdata     = pre_data_reg;
assign valid       = pre_vld_reg;
assign curr_empty  = !pre_vld_reg; // Assuming curr_empty reflects the validity of the data
assign sum_empty   = 1'b0;         // Unused in parent, assigned a default value
assign high_reload = 1'b0;         // Unused in parent, assigned a default value

endmodule
