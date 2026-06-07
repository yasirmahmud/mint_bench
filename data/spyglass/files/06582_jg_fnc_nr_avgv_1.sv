module FNC_NR_AVGV_example_1;
  reg [7:0] global_data;

  function automatic [7:0] update_and_return;
    input [7:0] input_val;
    begin
      global_data = input_val + 1; // Violation: Assigning to global_data
      update_and_return = input_val * 2;
    end
  endfunction

  initial begin
    global_data = 8'h00;
    #10;
    global_data = update_and_return(5);
  end
endmodule
