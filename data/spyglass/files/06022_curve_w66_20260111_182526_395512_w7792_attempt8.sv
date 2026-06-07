module curve_w66_20260111_182526_395512_w7792_attempt8 (
  input wire        clk,
  input wire        rst_n,
  input wire [2:0]  loop_count_in,
  output reg [7:0]  data_out
);

  reg [2:0] current_loop_limit; // This will hold a non-constant value for repeat

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h0;
      current_loop_limit <= 3'h0;
    end else begin
      // Assign non-constant value to the repeat expression variable
      current_loop_limit <= loop_count_in; // This makes it non-constant at elaboration time

      // W66 violation: The 'repeat' loop's expression 'current_loop_limit' is not a constant.
      // This makes the repeat loop unsynthesizable.
      repeat (current_loop_limit) begin
        data_out <= data_out + 1; // Perform a simple operation inside the loop
      end
    end
  end

endmodule
