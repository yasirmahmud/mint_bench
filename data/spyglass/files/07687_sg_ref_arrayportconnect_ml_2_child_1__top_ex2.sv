module top_ex2 (input wire [2:0] index_val);
  reg [7:0] multi_dim_array [0:3];

  // Fix for UndrivenInTerm-ML, W123, W287a:
  // Variable 'multi_dim_array' read but never set / is undriven.
  // Initialize all elements of the array to provide a defined value.
  initial begin
    for (int i = 0; i < 4; i = i + 1) begin
      multi_dim_array[i] = 8'h00; // Assign a default value (e.g., all zeros)
    end
  end

  sub_module inst_sub (.data_in(multi_dim_array[index_val]));
endmodule
