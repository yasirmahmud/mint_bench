module mod_nr_locl_example_2;

  task my_data_processor(input bit [7:0] data_in);
    reg [7:0] processed_data = 8'h00; // Violation: Local variable 'processed_data' initialized in task
    processed_data = data_in ^ 8'hFF;
    $display("Original: %h, Processed: %h", data_in, processed_data);
  endtask

  initial begin
    my_data_processor(8'hA5);
  end

endmodule
