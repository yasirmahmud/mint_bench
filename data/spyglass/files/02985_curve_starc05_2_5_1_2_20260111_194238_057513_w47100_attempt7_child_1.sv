module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  input wire clk,      // Added for synchronous enable
  input wire rst_n,    // Added for synchronous enable reset
  output wire i2c_sdat
);

  // Registered signal to hold the logic for the tristate enable
  // This resolves STARC05-2.5.1.2 by making the enable synchronous.
  reg enable_signal_r;

  // The enable condition is derived from combinatorial logic (OR operation)
  // and then registered to provide a stable enable signal.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // On reset, disable the tristate buffer (i.e., make i2c_sdat high-Z)
      enable_signal_r <= 1'b0; 
    end else begin
      enable_signal_r <= control_a || control_b;
    end
  end

  // Tristate buffer where the enable condition 'enable_signal_r'
  // is now a registered signal, resolving STARC05-2.5.1.2. The functional
  // intent of driving i2c_sdat based on control_a/b is preserved, but with
  // a single clock cycle latency and reset stability.
  assign i2c_sdat = enable_signal_r ? data_in : 1'bz;

endmodule
