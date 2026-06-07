module top_module_1 (
  output reg global_flag
);

  task set_flag;
    output reg flag_to_set; // 'flag_to_set' is declared as an output argument
    flag_to_set = 1'b1;
  endtask

  initial begin
    global_flag = 1'b0; // Initialize global_flag
    set_flag(global_flag); // Pass global_flag as an argument to the task
  end
endmodule
