module partial_assign_func_example2;

  function automatic [3:0] my_partial_func (input sel);
    my_partial_func = 4'b0; // Initialize all bits to 0 to ensure all bits are always assigned.
    // Original my_partial_func[0] = 1'b0; is now covered by the initialization.
    if (sel) begin
      my_partial_func[1] = 1'b1; // Bit 1 assigned here
    end else begin
      my_partial_func[2] = 1'b0; // Bit 2 assigned here (explicitly 0, also consistent with initialization)
    end
    // Bit [3] is now always 0 from initialization.
    // Bit [1] is 1 when 'sel' is 1, and 0 when 'sel' is 0 (from initialization).
    // Bit [2] is 0 when 'sel' is 0, and 0 when 'sel' is 1 (from initialization).
  endfunction

  logic selector;
  logic [3:0] func_result;

  initial begin
    selector = 1'b0;
    func_result = my_partial_func(selector);
    $display("Selector: %b, Function Result: %b", selector, func_result); // Fixes W528 by reading func_result
  end

endmodule
