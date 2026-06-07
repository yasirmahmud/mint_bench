module const_write_10;
  int value = 100; // Removed 'const' keyword to allow re-assignment
  function automatic int get_value();
    value = 200;
    return value;
  endfunction
endmodule
