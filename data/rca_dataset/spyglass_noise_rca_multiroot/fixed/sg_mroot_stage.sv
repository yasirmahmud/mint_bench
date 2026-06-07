module sg_mroot_stage #(
  parameter int DATA_W = 32
) (
  input  logic [DATA_W-1:0] data_in,
  output logic [DATA_W-1:0] data_out
);
  always_comb begin
    data_out = {data_in[DATA_W-2:0], data_in[DATA_W-1]};
  end
endmodule

