module curve_stx_ve_502_20260111_174119_575000_w36056_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire [1:0] sel,
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output reg [7:0] data_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h0;
    end else begin
      case(sel)
        2'b00: data_out <= data_in_a;
        2'b01: data_out <= data_in_b;
        default: data_out <= 8'hFF; // Default value to prevent latch
      endcase
    end
  end

  // This `endif` compiler directive is intentionally placed here
  // without a preceding `ifdef` or `ifndef` to trigger STX_VE_502.
`endif

endmodule
