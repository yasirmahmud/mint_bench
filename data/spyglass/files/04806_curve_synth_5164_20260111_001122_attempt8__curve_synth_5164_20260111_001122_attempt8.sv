module curve_synth_5164_20260111_001122_attempt8 (
  input wire clk,
  output wire out
);

  // Parameter to control the generation of the sub-module instance.
  // Set to 0 so the sub_module instance 'u_sub' is NOT instantiated.
  parameter ENABLE_SUB_INSTANCE = 1'b0;

  // The 'u_sub' instance is conditionally generated.
  // Since ENABLE_SUB_INSTANCE is 0, this block is not elaborated, and 'u_sub' does not exist.
  generate
    if (ENABLE_SUB_INSTANCE) begin : gen_block
      sub_module u_sub ();
    end
  endgenerate

  // This defparam attempts to modify a parameter of an instance 'u_sub'
  // that is expected within the 'gen_block' generate region.
  // However, because 'ENABLE_SUB_INSTANCE' is '0', the 'gen_block' is not elaborated,
  // and therefore 'u_sub' does not exist in the final design hierarchy.
  // SpyGlass should identify 'u_sub' as a component that is 'not found' because it's missing
  // from the elaborated hierarchy, leading to SYNTH_5164.
  defparam gen_block.u_sub.PARAM = 42;

  // Minimal logic to avoid unused input/output warnings.
  reg dummy_reg;
  always @(posedge clk) begin
    dummy_reg <= 1'b0;
  end
  assign out = dummy_reg;

endmodule
