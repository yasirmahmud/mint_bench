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
      // Initialize memory content during reset to ensure defined state and avoid warnings.
      // Using 'integer' for loop variable for Verilog-2001 compatibility.
      for (integer i = 0; i < 1024; i = i + 1) begin
          MyMemory[i] <= {36{1'b0}};
      end
    end else begin
      if (we) begin
        MyMemory[addr] <= data_in;
      end
      data_out <= MyMemory[addr]; // Read on every cycle, simple usage
    end
  end

endmodule
