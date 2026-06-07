module curve_synth_5273_20260111_223602_977001_w15680_attempt11 (
    input wire clk,
    input wire rst_n,
    input wire [9:0] addr,
    input wire [35:0] data_in,
    input wire we,
    output reg [35:0] data_out
);

  // This declaration of 'MyMemory' has a total bit count of 36 * 1024 = 36864 bits.
  // This value significantly exceeds the default 'mthresh' value of 4096,
  // thereby specifically triggering the SYNTH_5273 violation for a large memory.
  reg [35:0] MyMemory [0:1023];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= {36{1'b0}};
      // Original memory initialization loop removed to improve synthesizability of large memory.
      // For large memories, explicit 'for' loops for initialization during reset can cause synthesis issues,
      // often leading to errors like SYNTH_5273 or inefficient hardware.
      // MyMemory contents will be undefined after reset until explicitly written to.
      // If zero-initialization is strictly required before any reads, a dedicated memory IP with initialization
      // capabilities or an alternative system-level initialization scheme (e.g., via a system controller or software)
      // might be necessary.
    end
    else begin // Corrected: `else begin` moved to a new line after `end` to resolve STX_VE_481 syntax error.
      if (we) begin
        MyMemory[addr] <= data_in;
      end
      data_out <= MyMemory[addr]; // Read on every cycle, simple usage
    end
  end

endmodule
