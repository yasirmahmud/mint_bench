module another_example_mod;
  reg [3:0] state_var;

  task update_state_task;
    input [3:0] new_val;
    begin
      #1; // A task can contain time-controlling statements
      state_var = new_val;
    end
  endtask

  function automatic [3:0] get_next_state_func;
    input [3:0] input_state;
    begin
      update_state_task(input_state + 1); // TSK_NR_FUNC violation: Task called in a function
      get_next_state_func = state_var;
    end
  endfunction

  initial begin
    state_var = 4'h0;
    $display("Next state: %h", get_next_state_func(4'h5));
  end
endmodule
