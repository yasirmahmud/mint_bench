module same_loop_index_ex2;
 reg [7:0] data1, data2;

 always @* begin
  integer i; // Declare loop index as integer, local to this always block
  for (i = 0; i < 4; i = i + 1) begin
    // Loop body is empty to avoid W415a (multiple assignments within loop)
  end
  data1 = i - 1; // Assign the final desired value once after the loop (i.e., 3)
 end

 always @* begin
  integer j; // Declare a separate loop index as integer, local to this always block
  for (j = 0; j < 8; j = j + 1) begin
    // Loop body is empty to avoid W415a (multiple assignments within loop)
  end
  data2 = j - 1; // Assign the final desired value once after the loop (i.e., 7)
 end

endmodule
