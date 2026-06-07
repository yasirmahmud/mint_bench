module w162_ex2 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] data_out
);

  reg [7:0] data_reg;

  // SYNTH_5143: Initial block is ignored for synthesis
  // Replaced initial block with a synthesizable reset to achieve initial value.
  // Original: data_reg = 4'hF; (which is 8'h0F when zero-extended)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 8'h0F;
    end
    // else if no other logic, data_reg holds its value (implicit self-loop)
  end

  // W528: Variable 'data_reg[7:0]' set but not read.
  // Make data_reg an output to ensure it is read.
  assign data_out = data_reg;

endmodule
