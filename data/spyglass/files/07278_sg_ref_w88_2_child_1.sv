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
    end
    // No other write logic is present in the original design.
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
