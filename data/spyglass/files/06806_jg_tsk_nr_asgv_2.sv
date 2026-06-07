module module_tsk_nr_asgv_2;
  logic [3:0] shared_register;

  task modify_shared_reg(input logic [3:0] value_in);
    // This task assigns to shared_register, a module-level variable.
    shared_register = value_in;
  endtask

  initial begin
    shared_register = 4'h0;
    modify_shared_reg(4'hF);
    $display("shared_register = %h", shared_register);
  end
endmodule
