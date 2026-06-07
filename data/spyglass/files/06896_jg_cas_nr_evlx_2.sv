module cas_q_violation (
  input [1:0] sel,
  output reg out
);

always @(*) begin
  case (sel)
    2'b00: out = 1'b0;
    2'b01: out = 1'b1;
    2'b1?: out = 1'b0; // Case item expression contains '?'
    default: out = 1'b0;
  endcase
end

endmodule
