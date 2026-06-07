module curve_w415_20260111_195512_878064_w47100_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire enable,
  input wire data_in,
  output reg out_signal
);

// First driver for out_signal
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    out_signal <= 1'b0;
  end else if (enable) begin
    out_signal <= data_in;
  end else begin
    out_signal <= out_signal;
  end
end

// Second driver for out_signal, conflicting with the first
always @(posedge clk) begin
  if (data_in) begin
    out_signal <= ~out_signal;
  end
end

endmodule
