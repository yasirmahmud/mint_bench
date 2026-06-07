module FNC_NR_AVGV_example_2 (output reg [3:0] func_output);
  reg [3:0] module_state;

  function integer process_and_set_state;
    input integer current_val;
    begin
      module_state = current_val % 4; // Violation: Assigning to module_state
      process_and_set_state = current_val * 2;
    end
  endfunction

  initial begin
    module_state = 4'h1;
    #5;
    func_output = process_and_set_state(module_state);
  end
endmodule
