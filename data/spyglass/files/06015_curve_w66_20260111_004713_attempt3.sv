module curve_w66_20260111_004713_attempt3 (
  output reg [7:0] out_data
);

  reg [3:0] loop_count1;
  reg [3:0] loop_count2;
  reg [3:0] loop_count3;
  reg [3:0] loop_count4;

  initial begin
    // Initialize output and loop counters
    out_data = 8'h00;
    loop_count1 = 4'd5;
    loop_count2 = 4'd8;
    loop_count3 = 4'd12;
    loop_count4 = 4'd15;

    // W66 Violation 1: Repeat expression 'loop_count1' is not constant.
    // Although in an initial block, SpyGlass flags non-constant repeat expressions
    // as unsynthesizable even in this context.
    repeat (loop_count1) begin
      out_data = out_data + 1;
    end

    // W66 Violation 2
    repeat (loop_count2) begin
      out_data = out_data + 1;
    end

    // W66 Violation 3
    repeat (loop_count3) begin
      out_data = out_data + 1;
    end

    // W66 Violation 4
    repeat (loop_count4) begin
      out_data = out_data + 1;
    end

    // Add a simulation display to ensure out_data is used if not otherwise consumed
    $display("Simulation finished. Final out_data: %h", out_data);
  end

endmodule
