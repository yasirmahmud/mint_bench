module redef_macro_example2();
  `define CONFIG_MODE "DEBUG"

  // Some logic based on CONFIG_MODE
  parameter string current_mode = `CONFIG_MODE;

  // Later in the file, the macro is redefined
  `define CONFIG_MODE "RELEASE"

  parameter string new_mode = `CONFIG_MODE;

  initial begin
    $display("Mode 1: %s, Mode 2: %s", current_mode, new_mode);
  end

endmodule
