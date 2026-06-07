module curve_wrn_70_20260111_174512_047823_w47100_attempt9 (
  input wire clk,
  input wire rst,
  input wire enable,
  input wire [3:0] in_data,
  output reg [3:0] out_data
);

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used
  // The 'generate' block below is not controlled by a 'for', 'if', or 'case' statement.
  // This standalone usage of 'generate' is considered an obsolete construct in newer Verilog standards.
  generate begin : standalone_logic_block
    always @(posedge clk or posedge rst) begin
      if (rst) begin
        out_data <= 4'b0;
      end else if (enable) begin
        out_data <= in_data;
      end
    end
  end endgenerate

endmodule
