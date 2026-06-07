module curve_wrn_1473_20260111_183256_218991_w47100_attempt8 (
  input wire clk,
  input wire rst,
  output reg out_val
);

  // Instantiate a module type 'undefined_mod_type' that is not defined
  // anywhere in this file or any known library. This instance 'u_unresolved_instance'
  // therefore cannot be fully resolved by the tool.
  undefined_mod_type u_unresolved_instance ();

  // This 'defparam' statement attempts to set a parameter 'UNRESOLVED_PARAM'
  // for the instance 'u_unresolved_instance'.
  // Since the instance itself is based on an undefined module type,
  // the hierarchical reference 'u_unresolved_instance.UNRESOLVED_PARAM'
  // cannot be resolved, directly triggering a WRN_1473 violation.
  defparam u_unresolved_instance.UNRESOLVED_PARAM = 16'h1234;

  // Minimal logic to prevent unused signal warnings for ports
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_val <= 1'b0;
    end else begin
      out_val <= ~out_val;
    end
  end

endmodule
