module loop_var_mod_1();
  initial begin
    for (int i = 0; i < 5; i++) begin
      $display("i = %0d", i);
      i = i + 1; // Violation: loop variable 'i' modified inside the loop
    end
  end
endmodule
