module curve_synth_132_20260111_183938_083763_w7792_attempt8 (
  // Added a parameter to the top module to control the generate block.
  // This parameter's value will also be passed to the sub-module.
  parameter TOP_PARAM_SUB_PARAM = 1,
  input wire clk,
  input wire rst_n,
  output reg out_reg_signal
);

  // Instantiate the sub-module, passing the top-level parameter to its internal parameter.
  // The .sub_clk port connection is removed as the port itself was removed from sub_module.
  sub_module #(.SUB_PARAM(TOP_PARAM_SUB_PARAM)) u_sub_inst (
    // No clock port connection needed now.
  );

  // SYNTH_132 Violation Fix: The generate-if condition now uses a local parameter
  // (TOP_PARAM_SUB_PARAM) instead of a hierarchical reference (u_sub_inst.SUB_PARAM).
  // This resolves the synthesis error while maintaining the original functional behavior.
  generate
    if (TOP_PARAM_SUB_PARAM == 1) begin : gen_block_param_is_one
      always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          out_reg_signal <= 1'b0;
        end else begin
          out_reg_signal <= 1'b1; // Output 1 if TOP_PARAM_SUB_PARAM is 1
        end
      end
    end else begin : gen_block_param_is_not_one
      always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          out_reg_signal <= 1'b0;
        end else begin
          out_reg_signal <= 1'b0; // Output 0 if TOP_PARAM_SUB_PARAM is not 1
        end
      end
    end
  endgenerate

endmodule
