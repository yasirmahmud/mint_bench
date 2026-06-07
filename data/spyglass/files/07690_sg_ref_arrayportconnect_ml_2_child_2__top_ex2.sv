module top_ex2 (input wire [2:0] index_val);
  reg [7:0] multi_dim_array [0:3];

  // Fix for SYNTH_5143 (Initial block is ignored for synthesis) and
  // UndrivenInTerm-ML (Detected undriven input terminal).
  // The non-synthesizable 'initial' block is replaced by a synthesizable 'always @(*)' block
  // to continuously drive all elements of 'multi_dim_array' to 8'h00.
  // This ensures the array is always driven and synthesizable, preserving the initial behavior.
  always @(*) begin
    for (int i = 0; i < 4; i = i + 1) begin
      multi_dim_array[i] = 8'h00;
    end
  end

  sub_module inst_sub (.data_in(multi_dim_array[index_val]));
endmodule
