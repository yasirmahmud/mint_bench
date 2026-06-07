module test6 (
  output logic [WIDTH-1:0] dummy_out
);
  parameter WIDTH = 8;
  logic [(2*WIDTH)-1:0] full_word;
  logic [WIDTH-1:0] half_word;

  // Fix: 'full_word[15:8]' read but never set.
  // Initialize full_word to a known value to ensure it is set before being read.
  initial begin
    full_word = {(2*WIDTH){1'b1}};
  end

  // The original part-select syntax is already correct based on the design description.
  // It selects the upper 'WIDTH' bits of 'full_word' (e.g., full_word[15:8] for WIDTH=8).
  assign half_word = full_word[WIDTH +: WIDTH];

  // Fix: 'half_word[7:0]' set but not read.
  // Assign half_word to an output port to indicate it is being used.
  assign dummy_out = half_word;

endmodule
