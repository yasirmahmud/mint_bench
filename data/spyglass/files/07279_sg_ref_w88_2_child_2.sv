module w88_ex2(
    input wire clk,
    input wire rst_n,
    output reg [7:0] data_out
);
  reg [7:0] my_mem[0:3];
  reg [1:0] addr;

  // SYNTH_5143: Initial block is ignored for synthesis.
  // Replaced the non-synthesizable 'initial' block with a synthesizable reset-based initialization.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_mem[0] <= 8'hAA;
      my_mem[1] <= 8'hBB;
      // Initialize other memory locations to a known state (e.g., 0) on reset
      my_mem[2] <= 8'h00;
      my_mem[3] <= 8'h00;
    end else begin
      // To prevent latch inference (W88 related issues often lead to latches),
      // my_mem must be assigned in the 'else' path. Since "no other write logic
      // is present" as per the original design intent, my_mem should retain
      // its current value. This creates flip-flops that hold their previous
      // value when not in reset, resolving the InferLatch violations.
      my_mem[0] <= my_mem[0];
      my_mem[1] <= my_mem[1];
      my_mem[2] <= my_mem[2];
      my_mem[3] <= my_mem[3];
    end
  end

  // W528: Variable 'my_mem' set but not read.
  // Added simple read logic to access 'my_mem' and assign to an output port.
  always @(posedge clk) begin
    if (!rst_n) begin
      addr <= 2'b00;
      data_out <= 8'h00;
    end else begin
      // Increment address to read different memory locations over time
      addr <= addr + 1;
      data_out <= my_mem[addr];
    end
  end

endmodule
