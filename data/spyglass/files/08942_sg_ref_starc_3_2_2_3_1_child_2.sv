module starc_3_2_2_3_ex1 #(
  parameter WIDTH = 8
) (
  input clk,
  input rst,
  output [WIDTH-1:0] out_data
);

 reg [WIDTH-1:0] data;

 assign out_data = data; // Resolves W528: 'data' is now read.

 always @(posedge clk or posedge rst) begin
  if (rst) begin
   data <= 0; // Resolves SYNTH_5143: Replaces initial block with synthesizable reset logic.
  end
  // No 'else' block needed, as 'data' is only meant to be initialized to 0 and not updated further in this example.
 end

endmodule
