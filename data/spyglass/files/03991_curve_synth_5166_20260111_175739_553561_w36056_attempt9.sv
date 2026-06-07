module curve_synth_5166_20260111_175739_553561_w36056_attempt9 (
  input wire clk,
  input wire rst_n,
  output reg [1:0] counter_out
);

  // First SYNTH_5166 violation: $display in an initial block.
  // Initial blocks are typically for simulation setup and are not synthesizable.
  initial begin
    $display("INFO: Module simulation started at %t", $time); // SYNTH_5166 #1
  end

  reg [1:0] count; // Internal counter for example

  // Second SYNTH_5166 violation: $display in an always block, triggered by a specific condition.
  // This always block implements a simple synthesizable counter.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count <= 2'b00;
      counter_out <= 2'b00;
    end else begin
      count <= count + 2'b01;
      counter_out <= count; // Update output with current count

      if (count == 2'b10) begin // Trigger $display when count reaches 2
        $display("DEBUG: Counter reached %d at %t", count, $time); // SYNTH_5166 #2
      end
    end
  end

endmodule
