module top_module_2;
  logic [3:0] shared_value;

  task display_shared_value(input logic [3:0] value_to_display);
    // shared_value is now passed as an argument, resolving TSK_NR_UGLV related issues
    $display("Shared value: %d", value_to_display);
  endtask

  initial begin
    shared_value = 4'd5;
    display_shared_value(shared_value);
    shared_value = 4'd10;
    display_shared_value(shared_value);
  end
endmodule
