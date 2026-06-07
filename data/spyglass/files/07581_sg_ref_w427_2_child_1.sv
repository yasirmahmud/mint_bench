module w427_ex2;
  reg [7:0] global_data;

  initial begin
    global_data = 8'h00;
  end

  task my_task;
    reg [7:0] local_var;
    begin
      local_var = global_data;
      $display("INFO: my_task assigned local_var = %h from global_data.", local_var);
    end
  endtask
endmodule
