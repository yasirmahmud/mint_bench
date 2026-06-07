`define BUFFER_SIZE 16
`define BUFFER_SIZE 32 // WRN_26: Redefinition of macro BUFFER_SIZE

module curve_wrn_26_20260111_222950_644596_w15680_attempt12 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Use the macro and ports to avoid unused warnings.
  // The macro will evaluate to its last defined value (32 in this case).
  // We use [7:0] for MAX_VAL to ensure consistent width for comparison if BUFFER_SIZE is larger than 8 bits.
  localparam [7:0] MAX_VAL = `BUFFER_SIZE;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      if (data_in < MAX_VAL) begin
        data_out <= data_in + 1'b1;
      end else begin
        data_out <= data_in;
      end
    end
  end

endmodule
