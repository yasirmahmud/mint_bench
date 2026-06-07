module module_tsk_nr_asgv_2;
  logic [3:0] shared_register;

  // Fix for W426: Pass shared_register as an inout argument to resolve the warning
  // "Global variable 'shared_register' should not be 'set' in task".
  // This ensures the task operates on its arguments rather than directly on module-level variables.
  task modify_shared_reg(inout logic [3:0] reg_to_modify, input logic [3:0] value_in);
    reg_to_modify = value_in;
  endtask

  initial begin
    shared_register = 4'h0;
    // Call the task, passing shared_register as the inout argument.
    modify_shared_reg(shared_register, 4'hF);
    $display("shared_register = %h", shared_register);
  end
endmodule
