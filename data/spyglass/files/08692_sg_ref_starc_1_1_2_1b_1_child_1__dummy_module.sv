module dummy_module();
  // SpyGlass STARC-1.1.2.1b fix: Add a dummy statement to avoid empty module definition warning.
  initial begin
    // This block does nothing but makes the module non-empty.
  end
endmodule
