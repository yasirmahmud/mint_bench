module verilator_constraintign_10_child_1 (
  input clk,
  input rst_n,
  output reg [3:0] s
);

  // Original intent: 's' was a randomized integer within a SystemVerilog class,
  // constrained to the range [0, 9]. The Verilator warning CONSTRAINTIGN arises
  // from Verilator's limited support for these advanced SystemVerilog randomization
  // constructs, which are typically found in testbenches, not synthesizable RTL.
  //
  // SpyGlass, as an RTL linting tool, flags SystemVerilog class declarations
  // (ELAB_6312) and indicates no proper top-level design unit (NoTopDUFound)
  // because these constructs are not part of synthesizable hardware design.
  //
  // To resolve these SpyGlass violations and provide a synthesizable RTL design
  // that functionally represents 's' taking values within the original constrained
  // range [0, 9], we replace the non-synthesizable class and randomization with a
  // simple RTL counter. This counter cycles through values from 0 to 9, effectively
  // embodying the procedural generation of constrained values suggested in the
  // design description as a mitigation strategy for advanced constraints.

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s <= 4'd0;
    end else begin
      if (s == 4'd9) begin
        s <= 4'd0;
      end else begin
        s <= s + 4'd1;
      end
    end
  end

endmodule
