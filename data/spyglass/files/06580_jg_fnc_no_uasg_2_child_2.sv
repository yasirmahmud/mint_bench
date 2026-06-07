module partial_assign_func_example2 (
  output logic [3:0] final_func_result
);

  function automatic [3:0] my_partial_func (input sel);
    my_partial_func = 4'b0; // Initialize all bits to 0 to ensure all bits are always assigned.
    if (sel) begin
      my_partial_func[1] = 1'b1; // Bit 1 assigned here
    end else begin
      my_partial_func[2] = 1'b0; // Bit 2 assigned here (explicitly 0, also consistent with initialization)
    end
  endfunction

  logic selector;
  // The 'func_result' variable is removed as its value is now directly assigned to the output port.

  initial begin
    selector = 1'b0;
    final_func_result = my_partial_func(selector); // Assign function result directly to the output port
    $display("Selector: %b, Function Result: %b", selector, final_func_result);
  end

endmodule
