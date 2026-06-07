module my_module_ex2(
  input wire clk,
  input wire rst_n,
  input wire [1:0] addr,
  output reg [7:0] dout
);

  reg [7:0] my_record_like_data [0:3];

  // Fix SYNTH_5143: Replace non-synthesizable initial block with reset logic.
  // This ensures 'my_record_like_data' is initialized in synthesizable hardware.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_record_like_data[0] <= 8'hAA;
      my_record_like_data[1] <= 8'hBB;
      my_record_like_data[2] <= 8'h00; // Explicitly initialize unassigned elements to avoid 'X' in synthesis
      my_record_like_data[3] <= 8'h00;
    end
    // 'my_record_like_data' retains its value otherwise, as there's no other write logic.
  end

  // Fix W528: The variable 'my_record_like_data' was set but never read.
  // By adding 'addr' input and 'dout' output, we provide a way to read from it,
  // thus making it a functionally used part of the design and removing the warning.
  always @(posedge clk) begin
    dout <= my_record_like_data[addr];
  end

endmodule
