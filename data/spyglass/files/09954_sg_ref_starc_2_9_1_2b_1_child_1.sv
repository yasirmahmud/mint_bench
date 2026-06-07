module starc_2_9_1_2b_ex1;
  localparam LIMIT_VALUE = 5; // STARC-2.9.1.2b: Changed 'reg' to 'localparam' for a constant loop limit
  integer i; // W480: Changed 'reg' to 'integer' for loop index

  initial begin
    // The assignment 'non_constant_limit = 5;' is removed as LIMIT_VALUE is a localparam
    for (i = 0; i < LIMIT_VALUE; i = i + 1) ;
  end
endmodule
