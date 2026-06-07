module curve_wrn_70_20260112_001950_305179_w37744_attempt15 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used.
  // This 'generate' block is not controlled by a 'for', 'if', or 'case' statement.
  generate begin : standalone_register_block
    always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        data_out <= 4'b0;
      end else begin
        data_out <= data_in;
      end
    end
  end
  endgenerate

endmodule
