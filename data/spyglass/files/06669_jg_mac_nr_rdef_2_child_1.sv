module redef_macro_example2();
  // The original macros are replaced by localparam to avoid redefinition warnings
  // and to make string values compatible with synthesis tools (by representing them as bit vectors).

  // Define the first mode value as a localparam
  // "DEBUG" has 5 characters, so 5 * 8 = 40 bits
  localparam [8*5-1:0] current_mode_str = "DEBUG";

  // Define the second mode value as a localparam
  // "RELEASE" has 7 characters, so 7 * 8 = 56 bits
  localparam [8*7-1:0] new_mode_str = "RELEASE";

  initial begin
    // $display can correctly interpret packed bit vectors as strings with %s
    $display("Mode 1: %s, Mode 2: %s", current_mode_str, new_mode_str);
  end

endmodule
