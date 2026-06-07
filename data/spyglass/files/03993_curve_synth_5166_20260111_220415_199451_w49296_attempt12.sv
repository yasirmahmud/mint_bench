module curve_synth_5166_20260111_220415_199451_w49296_attempt12 (
  input wire clk,
  input wire rst_n,
  input wire enable_i,
  input wire [7:0] data_in_i,
  output reg [7:0] data_out_o
);

  reg [7:0] data_reg; // Primary data register

  // SYNTH_5166 violation #1: $display in a sequential block (always_ff)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 8'h00; // Asynchronous reset
      $display("[%0t] Reset detected: data_reg cleared.", $time); // First violation
    end else if (enable_i) begin
      data_reg <= data_in_i; // Synchronous data load
    end else begin
      data_reg <= data_reg; // Retain value to prevent latch inference
    end
  end

  // SYNTH_5166 violation #2: $display in a combinational block (always_comb)
  // This block monitors if the input data matches the registered data,
  // potentially indicating a stable state or a missed update.
  always @(*) begin
    if (data_in_i == data_reg) begin
      $display("[%0t] Data stable: Input (%h) matches registered value (%h).", $time, data_in_i, data_reg); // Second violation
    end
  end

  // Output assignment
  assign data_out_o = data_reg; // Connect output to the register

endmodule
