module curve_stx_ve_1182_20260111_214011_365310_w39504_attempt12 ();

  // STX_VE_1182: Genvar expected as identifier
  // This rule is triggered because an 'integer' variable is used as the loop iterator
  // in a generate for-loop, where a 'genvar' type is required.
  genvar k_index; // This declaration will cause STX_VE_1182 when used below

  generate
    for (k_index = 0; k_index < 4; k_index = k_index + 1) begin : gen_loop_instance
      // Minimal logic inside the generate block to avoid other warnings/violations
      // Declare and assign a local wire to prevent unused signal warnings.
      wire [1:0] generated_data_bit;
      assign generated_data_bit = 2'b01;
    end
  endgenerate

endmodule
