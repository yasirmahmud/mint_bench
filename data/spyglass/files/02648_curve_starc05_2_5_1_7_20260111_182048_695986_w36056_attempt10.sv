module curve_starc05_2_5_1_7_20260111_182048_695986_w36056_attempt10 (
  input wire [2:0] i_enable,
  input wire [2:0] i_data,
  output wire [2:0] o_tri_state_vec,
  output reg [2:0] o_logic_out
);

  // Drive 'o_tri_state_vec' as a 3-bit tri-state output, where each bit is independently tri-stated.
  // A bit resolves to 'z' when its corresponding enable is low.
  assign o_tri_state_vec[0] = i_enable[0] ? i_data[0] : 1'bz;
  assign o_tri_state_vec[1] = i_enable[1] ? i_data[1] : 1'bz;
  assign o_tri_state_vec[2] = i_enable[2] ? i_data[2] : 1'bz;

  // The individual bits of the tri-state output vector 'o_tri_state_vec'
  // are used in conditional expressions of separate if statements.
  // This directly triggers three STARC05-2.5.1.7 violations, one for each bit used.
  always @(*) begin
    // Violation 1: o_tri_state_vec[0] used in an if condition
    if (o_tri_state_vec[0]) begin
      o_logic_out[0] = 1'b1;
    end else begin
      o_logic_out[0] = 1'b0;
    end

    // Violation 2: o_tri_state_vec[1] used in an if condition
    if (o_tri_state_vec[1]) begin
      o_logic_out[1] = 1'b1;
    end else begin
      o_logic_out[1] = 1'b0;
    end

    // Violation 3: o_tri_state_vec[2] used in an if condition
    if (o_tri_state_vec[2]) begin
      o_logic_out[2] = 1'b1;
    end else begin
      o_logic_out[2] = 1'b0;
    end
  end

endmodule
