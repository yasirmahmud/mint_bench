module top_module_1;
  reg global_flag;

  task set_flag;
    // global_flag is used here but not declared locally or passed as an argument
    global_flag = 1'b1;
  endtask

  initial begin
    global_flag = 1'b0;
    set_flag;
  end
endmodule
