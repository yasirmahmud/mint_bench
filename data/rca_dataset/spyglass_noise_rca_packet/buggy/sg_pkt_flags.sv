module sg_pkt_flags #(
  parameter int DATA_W = 32
) (
  input  logic [DATA_W-1:0] data_in,
  output logic [DATA_W-1:0] flags_out
);
  always_comb begin
    flags_out = (data_in << 1) ^ (data_in >> 1) ^ {DATA_W{^data_in}};
  end
endmodule

