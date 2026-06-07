module BreakInMultiDimForeach_ex1();
  reg [7:0] data[0:1][0:2];
  integer i, j; // Declare loop variables for 'for' loops

  initial begin : loop_block // Name the block to allow 'disable' to exit both loops
    for (i = 0; i <= 1; i = i + 1) begin
      for (j = 0; j <= 2; j = j + 1) begin
        if (i == 0 && j == 0) begin
          // The 'foreach' loop with 'break' exits the entire multi-dimensional iteration.
          // To replicate this behavior with nested 'for' loops, we use 'disable' on a named block
          // encompassing all loops.
          disable loop_block;
        end
      end
    end
  end
endmodule
