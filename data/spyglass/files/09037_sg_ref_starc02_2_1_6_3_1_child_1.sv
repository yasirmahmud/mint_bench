module star_c02_2_1_6_3_ex1 (input wire [2:0] idx, output reg [7:0] out_val);
 reg [7:0] data_array [7:0];

 // Fix for SpyGlass violations UndrivenInTerm-ML and W123:
 // Initialize data_array to prevent undriven signals.
 initial begin
  for (int i = 0; i < 8; i = i + 1) begin
   data_array[i] = 8'h00; // Initialize all elements to 0
  end
 end

 always @(*) begin
  out_val = data_array[idx + 1];
 end
endmodule
