`define FEATURE_ENABLE 1
`define FEATURE_ENABLE 0 // WRN_26: Redefinition of macro FEATURE_ENABLE

module curve_wrn_26_20260111_222950_644596_w15680_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      // The macro 'FEATURE_ENABLE' will take its last defined value (0 in this case).
      // This logic ensures ports are used and avoids unused warnings.
      if (`FEATURE_ENABLE) begin
        data_out <= data_in + 1'b1;
      end else begin
        data_out <= data_in;
      end
    end
  end

endmodule
