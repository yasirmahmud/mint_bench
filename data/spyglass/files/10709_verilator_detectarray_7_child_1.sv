module detect_array_07 (
  input wire clk, // Added clock input to synchronize registers
  input wire rst  // Added reset input for register initialization
);
  typedef struct packed { logic [15:0] val; } big_struct_t;
  reg big_struct_t s_a; // Changed to 'reg' to allow sequential assignment
  reg big_struct_t s_b; // Changed to 'reg' to allow sequential assignment

  // Introduced a synchronous block to break the combinatorial loop
  // 's_a' and 's_b' now become registers, resolving the CombLoop violations.
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      s_a <= '0; // Initialize s_a on reset
      s_b <= '0; // Initialize s_b on reset
    end else begin
      // These non-blocking assignments now create a sequential dependency,
      // where s_a and s_b will swap their values every clock cycle.
      s_a <= s_b;
      s_b <= s_a;
    end
  end

endmodule
