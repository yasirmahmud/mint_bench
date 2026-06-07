module my_module_w499 (
  input wire [7:0] data_in,
  output wire [7:0] result
);

  function [7:0] my_func_w499;
    input [7:0] in_data;
    begin
      // Only assign the lower 4 bits of the function's return value.
      // The upper 4 bits (my_func_w499[7:4]) are left unassigned, triggering W499.
      my_func_w499[3:0] = in_data[3:0];
    end
  endfunction

  assign result = my_func_w499(data_in);

endmodule
