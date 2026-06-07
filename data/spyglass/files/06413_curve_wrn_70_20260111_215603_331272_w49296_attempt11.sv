module curve_wrn_70_20260111_215603_331272_w49296_attempt11 (
  input clk,
  input rst,
  input enable_in,
  output reg data_out
);

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used
  // This 'generate' block is not controlled by a 'for', 'if', or 'case' statement.
  generate begin : standalone_register_block_v9
    // An 'always' block driving the output is placed directly inside this standalone generate block.
    always @(posedge clk or posedge rst) begin
      if (rst) begin
        data_out <= 1'b0;
      end else begin
        data_out <= enable_in;
      end
    end

  end endgenerate

endmodule
