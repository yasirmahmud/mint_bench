module STARC05_2_1_8_6_ex1;
  reg global_sig;

  // Fix for violation W123: Variable 'global_sig' read but never set.
  // Initialize global_sig to ensure it has a defined value before being read.
  initial begin
    global_sig = 1'b0;
  end

  function automatic [0:0] my_func;
    input [0:0] local_in;
    begin
      my_func = global_sig & local_in;
    end
  endfunction
endmodule
