module curve_stx_ve_1182_20260110_065419_attempt1 (
  input wire clk,
  input wire reset,
  output wire [1:0] out_data
);

  // Declare 'idx' as an integer, which is not a genvar.
  // Using an integer as a loop variable in a generate for-loop
  // will trigger STX_VE_1182.
  integer idx;

  generate
    for (idx = 0; idx < 2; idx = idx + 1) begin : gen_block
      reg [0:0] local_toggle_reg;

      always @(posedge clk or posedge reset) begin
        if (reset) begin
          local_toggle_reg <= 1'b0;
        end else begin
          local_toggle_reg <= ~local_toggle_reg;
        end
      end

      // Assign the local register to the corresponding bit of the output array.
      // This ensures 'local_toggle_reg' is used and 'out_data' bits are driven.
      assign out_data[idx] = local_toggle_reg;
    end
  endgenerate

endmodule
