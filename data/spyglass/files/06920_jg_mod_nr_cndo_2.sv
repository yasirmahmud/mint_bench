module mod_nr_cndo_neq (
  input wire [2:0] data_in,
  input wire [2:0] compare_val,
  output reg       out_neq
);

always @* begin
  if (data_in !== compare_val) begin
    out_neq = 1'b1;
  end else begin
    out_neq = 1'b0;
  end
end

endmodule
