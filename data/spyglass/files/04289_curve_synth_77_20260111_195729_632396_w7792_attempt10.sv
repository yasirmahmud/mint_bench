module curve_synth_77_20260111_195729_632396_w7792_attempt10 (
  input clk,
  input reset,
  input en,
  input [7:0] data_in,
  output [7:0] data_out
);

  reg [7:0] my_var; // Target variable for SYNTH_77 violation

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      my_var <= 8'd0; // Non-blocking assignment
    end else if (en) begin
      my_var = data_in; // Blocking assignment to 'my_var'
    end else begin
      my_var <= my_var + 1'b1; // Another non-blocking assignment to 'my_var'
    end
  end

  assign data_out = my_var;

endmodule
