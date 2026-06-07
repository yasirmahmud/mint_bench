module curve_stx_ve_533_20260111_162340_094711_w31260_attempt2 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  localparam LP_DIVIDEND = 16;
  localparam LP_DIVISOR  = 4;
  localparam LP_QUOTIENT = `DIV(LP_DIVIDEND, LP_DIVISOR);

  always @(*) begin
    data_out = data_in + LP_QUOTIENT;
  end

endmodule
