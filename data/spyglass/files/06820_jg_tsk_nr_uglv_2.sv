module top_module_2;
  logic [3:0] shared_value;

  task display_shared_value;
    // shared_value is accessed here but not declared locally or passed as an argument
    $display("Shared value: %d", shared_value);
  endtask

  initial begin
    shared_value = 4'd5;
    display_shared_value;
    shared_value = 4'd10;
    display_shared_value;
  end
endmodule
