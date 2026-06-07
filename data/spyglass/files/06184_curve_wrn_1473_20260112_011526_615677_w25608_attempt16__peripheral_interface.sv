// This is a submodule that performs a simple data registration.
// Crucially, it declares NO parameters.
module peripheral_interface (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output wire [7:0] data_out
);
  // Register data to avoid unused signal warnings and create minimal functionality.
  reg [7:0] data_q;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_q <= 8'h00;
    end else begin
      data_q <= data_in;
    end
  end

  assign data_out = data_q;

endmodule
