module curve_w289_20260112_004126_628388_w47152_attempt13 (
  input wire clk,
  input wire reset_n,
  output reg output_flag
);

  real val_a;
  real val_b;
  reg match_a;
  reg match_b;

  initial begin
    val_a = 10.5; // Initialize real variable
    val_b = 20.25; // Initialize another real variable
  end

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      output_flag <= 1'b0;
      match_a <= 1'b0;
      match_b <= 1'b0;
    end else begin
      // W289 violation #1: A real_var operand 'val_a' should not be used with logical comparison operator '=='
      if (val_a == 10.5) begin
        match_a <= 1'b1;
        $display("Real value A matched at time %0t", $time);
      end else begin
        match_a <= 1'b0;
      end

      // W289 violation #2: A real_var operand 'val_b' should not be used with logical comparison operator '=='
      if (val_b == 20.25) begin
        match_b <= 1'b1;
        $display("Real value B matched at time %0t", $time);
      end else begin
        match_b <= 1'b0;
      end

      output_flag <= match_a | match_b; // Combine flags to determine output_flag
    end
  end

endmodule
