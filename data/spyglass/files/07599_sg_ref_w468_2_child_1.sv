module w468_ex2 (
    output wire [7:0] read_data
);
 reg [7:0] data_array [0:15];
 reg [2:0] narrow_index;
 integer i;

 initial begin
  // Initialize data_array to resolve W123 (Variable 'data_array' read but never set)
  for (i = 0; i <= 15; i = i + 1) begin
   data_array[i] = i;
  end
  narrow_index = 3'd0;
 end

 // Assign read_data combinatorially to resolve W528 (Variable 'read_data' set but not read)
 // and to avoid SYNTH_5143 for this specific assignment within the initial block.
 // Since narrow_index is initialized once and not changed, read_data effectively becomes a constant output.
 assign read_data = data_array[narrow_index];

endmodule
