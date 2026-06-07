module curve_synth_132_20260111_183938_083763_w7792_attempt8 (
  input wire clk,
  input wire rst_n,
  output reg out_reg_signal
);

  // Instantiate the sub-module
  sub_module u_sub_inst (
    .sub_clk (clk) // Connect clk to avoid unused port warnings in sub_module
  );

  // SYNTH_132 Violation: Hierarchical reference used in a generate-if condition.
  // Synthesis tools typically do not support hierarchical references for static elaboration,
  // especially when they determine module structure.
  generate
    if (u_sub_inst.SUB_PARAM == 1) begin : gen_block_param_is_one
      always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          out_reg_signal <= 1'b0;
        end else begin
          out_reg_signal <= 1'b1; // Output 1 if SUB_PARAM is 1
        end
      end
    end else begin : gen_block_param_is_not_one
      always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          out_reg_signal <= 1'b0;
        end else begin
          out_reg_signal <= 1'b0; // Output 0 if SUB_PARAM is not 1
        end
      end
    end
  endgenerate

endmodule
