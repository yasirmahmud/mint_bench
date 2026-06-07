module curve_synth_5166_20260110_154438_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  reg [7:0] internal_pipeline_reg;

  // Synthesizable logic to demonstrate signal usage and functional context
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_pipeline_reg <= 8'h00;
      data_out <= 8'h00;
    end else begin
      internal_pipeline_reg <= data_in; // pipeline data_in
      data_out <= internal_pipeline_reg; // output registered data
    end
  end

  // SYNTH_5166 violation 1: $display in an initial block
  // Initial blocks are purely for simulation and cannot be synthesized.
  initial begin
    $display("[%0t] curve_synth_5166_attempt5: Module initialization complete.", $time);
  end

  // SYNTH_5166 violation 2: $display in a combinational always block
  // This $display is based on a combinational condition but is unsynthesizable.
  always @(data_in or internal_pipeline_reg) begin
    // This condition is just for demonstrating a combinational context for $display.
    if (data_in != internal_pipeline_reg) begin
      $display("[%0t] Warning: Data pipeline mismatch detected! Input: %h, Registered: %h", $time, data_in, internal_pipeline_reg);
    end
    // This block does not drive any 'reg' or 'wire' to avoid latches or multiple drivers.
    // 'data_out' is driven exclusively by the synchronous always block.
  end

endmodule
