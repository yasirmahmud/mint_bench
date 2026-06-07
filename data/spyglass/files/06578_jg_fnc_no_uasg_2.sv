module partial_assign_func_example2;

  function automatic [3:0] my_partial_func (input sel);
    my_partial_func[0] = 1'b0; // Bit 0 is always assigned
    if (sel) begin
      my_partial_func[1] = 1'b1; // Bit 1 assigned here
    end else begin
      my_partial_func[2] = 1'b0; // Bit 2 assigned here
    end
    // Bit [3] is never assigned.
    // Bit [1] is unassigned when 'sel' is 0.
    // Bit [2] is unassigned when 'sel' is 1.
  endfunction

  logic selector;
  logic [3:0] func_result;

  initial begin
    selector = 1'b0;
    func_result = my_partial_func(selector);
  end

endmodule
