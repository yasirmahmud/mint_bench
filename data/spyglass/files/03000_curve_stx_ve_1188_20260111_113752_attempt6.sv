module curve_stx_ve_1188_20260111_113752_attempt6 (
  input wire clk,
  input wire rst_n,
  output reg [3:0] data_out
);

  // Declare genvar at the module level
  genvar i;

  // This is a procedural always block
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 4'b0;
    end else begin
      // STX_VE_1188: Invalid context for genvar 'i'.
      // A genvar is a compile-time construct for generate blocks
      // and cannot be used as a loop variable in a procedural (runtime) block like 'always'.
      for (i = 0; i < 4; i = i + 1) begin
        data_out[i] <= i[0]; // Simple assignment to use 'i' and satisfy syntax
      end
    end
  end

endmodule
