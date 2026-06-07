module top_module_1;
  reg [7:0] data_reg;

  task my_simple_task;
    input [7:0] in_val;
    begin
      data_reg = in_val + 1;
    end
  endtask

  function automatic [7:0] process_value_func;
    input [7:0] current_val;
    begin
      my_simple_task(current_val); // TSK_NR_FUNC violation: Task called in a function
      process_value_func = data_reg;
    end
  endfunction

  initial begin
    data_reg = 8'h00;
    $display("Processed value: %h", process_value_func(8'h0A));
  end
endmodule
