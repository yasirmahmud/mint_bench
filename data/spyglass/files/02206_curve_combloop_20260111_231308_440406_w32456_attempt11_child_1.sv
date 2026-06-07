module curve_combloop_20260111_231308_440406_w32456_attempt11 (
  input wire clk,   // Added clock input to break combinational loop with registers
  input wire rst_n, // Added active-low reset input for initialization
  input wire in_val,
  output wire out_val
);

  reg loop_s1_reg;
  reg loop_s2_reg;
  reg loop_s3_reg;

  wire loop_s1_next;
  wire loop_s2_next;
  wire loop_s3_next;

  // Combinational logic for next state values, based on current registered state
  // The loop is broken by referencing the _reg (registered current state) values
  // and producing _next (combinational next state) values.
  assign loop_s1_next = loop_s3_reg & in_val;
  assign loop_s2_next = loop_s1_next | in_val;
  assign loop_s3_next = ~loop_s2_next;

  // Sequential logic to update the registered state on the positive clock edge
  // and reset on active-low asynchronous reset.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      loop_s1_reg <= 1'b0;
      loop_s2_reg <= 1'b0;
      loop_s3_reg <= 1'b0;
    end else begin
      loop_s1_reg <= loop_s1_next;
      loop_s2_reg <= loop_s2_next;
      loop_s3_reg <= loop_s3_next;
    end
  end

  // Assign one of the registered loop signals to the output to prevent unused signal warnings.
  assign out_val = loop_s1_reg;

endmodule
