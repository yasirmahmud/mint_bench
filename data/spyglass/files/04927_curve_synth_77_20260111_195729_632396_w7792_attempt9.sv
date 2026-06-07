module curve_synth_77_20260111_195729_632396_w7792_attempt9 (
  input clk,
  input reset,
  input [7:0] d_in,
  output [7:0] data_out
);

  reg [7:0] my_var; // Target variable for SYNTH_77 violation

  // Non-blocking assignment for my_var
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      my_var <= 8'h00;
    end else begin
      my_var <= d_in;
    end
  end

  // Blocking assignment for my_var
  initial begin
    #1; // Introduce a minimal delay for simulation behavior, not relevant for synthesis
    my_var = 8'hAA; // Blocking assignment to the same 'my_var'
  end

  assign data_out = my_var;

endmodule
