module curve_stx_ve_417_20260110_193730_attempt8 (
  input  clk,
  input  rst,
  input  data_in_port,
  output reg data_out_port
);

  // Internal wire that directly drives an output (valid output-path)
  wire valid_path_wire;
  assign valid_path_wire = data_in_port;

  // Internal wire that does NOT drive any module output (invalid output-path for pulsestyle)
  wire unconnected_internal_wire;
  assign unconnected_internal_wire = clk ^ rst; // Make sure it's used to avoid unused signal warning

  // Functional logic (simple D-flop)
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out_port <= 1'b0;
    end else begin
      data_out_port <= valid_path_wire; // Connects to an output, so 'valid_path_wire' is an output-path
    end
  end

  specify
    // Violation 1 (STX_VE_417): 'data_in_port' is an input port.
    // Inputs are not valid output-paths for pulsestyle directives.
    pulsestyle_ondetect data_in_port;

    // Violation 2 (STX_VE_417): 'unconnected_internal_wire' is an internal signal
    // that does not drive any module output. Thus, it's not a valid output-path.
    pulsestyle_ondetect unconnected_internal_wire;

    // A valid path delay from input to output to make the specify block syntactically complete.
    // This path is functionally relevant to the always block.
    (clk => data_out_port) = (1, 1);
  endspecify

endmodule
