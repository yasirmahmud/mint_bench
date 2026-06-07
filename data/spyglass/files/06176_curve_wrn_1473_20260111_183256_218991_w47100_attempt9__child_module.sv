module child_module #(
  parameter KNOWN_PARAM = 8'h00
) (
  input wire clk,
  output reg out_data
);
  // Use KNOWN_PARAM to prevent unused parameter warning
  always @(posedge clk) begin
    out_data <= KNOWN_PARAM + 1;
  end
endmodule
