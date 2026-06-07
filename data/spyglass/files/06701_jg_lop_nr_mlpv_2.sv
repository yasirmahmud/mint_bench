module loop_var_mod_2();
  initial begin
    for (int j = 0; j < 10; j++) begin
      $display("j = %0d", j);
      j = 0; // Violation: loop variable 'j' modified inside the loop
    end
  end
endmodule
