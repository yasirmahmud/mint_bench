module LOP_NR_IDTY_example1;
  initial begin
    logic i; // Loop variable 'i' is of type 'logic', not recommended
    for (i = 0; i < 10; i++) begin
      $display("Current value: %0d", i);
    end
  end
endmodule
