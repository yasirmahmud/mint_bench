module signed_packed_mda_ex1 (
    input wire clk,
    input wire rst_n, // Asynchronous active-low reset
    output wire signed [7:0] out_data_0_0 // Output to observe data_array[0][0] and resolve W528
);

 reg signed [7:0] data_array [0:1][0:1];

 // Resolve SYNTH_5143: Move initial block assignment to a synthesizable always block with reset.
 // On reset, data_array[0][0] is initialized to 8'hFF.
 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
   data_array[0][0] <= 8'hFF; // Initialize data_array[0][0] to 8'hFF on reset
  end
  // No other assignments are specified, so data_array[0][0] will hold its value.
  // Other elements of data_array are not explicitly initialized by the original design.
 end

 // Resolve W528: 'data_array' set but not read. Connect it to an output.
 assign out_data_0_0 = data_array[0][0];

endmodule
