module curve_synth_5306_20260110_181614_attempt9 (
  input clk,
  input rst,
  output reg [7:0] data_out
);

  reg [7:0] internal_data; // Declared to avoid unused signals and implicit nets

  // This always block contains a named block 'data_manipulation_block'.
  always @(posedge clk) begin : data_manipulation_block // Named block within this always statement
    if (rst) begin
      internal_data <= 8'h00;
    end else begin
      internal_data <= internal_data + 1;
    end
  end

  // This separate always block attempts to disable 'data_manipulation_block'.
  // According to Verilog scope rules for 'disable', a named block can only be
  // disabled if it is within the lexical scope of the 'disable' statement or
  // an enclosing block/task/function. Since 'data_manipulation_block' is defined
  // within a *parallel* always block, it is not in the lexical scope of this
  // always block, leading to a SYNTH_5306 violation.
  always @(negedge clk) begin
    if (!rst) begin
      disable data_manipulation_block; // SYNTH_5306 violation: 'data_manipulation_block' is not in scope
    end
  end

  assign data_out = internal_data; // Connect to output to avoid unused signal warnings

endmodule
