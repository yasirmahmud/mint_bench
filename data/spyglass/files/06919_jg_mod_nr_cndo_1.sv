module mod_nr_cndo_eq (
  input wire [1:0] a,
  input wire [1:0] b,
  output reg       out_eq
);

always @* begin
  if (a === b) begin
    out_eq = 1'b1;
  end else begin
    out_eq = 1'b0;
  end
end

endmodule
