module sg_noise_probe #(
  parameter int DATA_W = 32
) (
  input  logic [DATA_W-1:0] data_in,
  input  logic [1:0]        mode,
  output logic [DATA_W-1:0] data_out,
  output logic              parity
);
  always_comb begin
    parity = ^data_in;
    case (mode)
      2'd0: data_out = data_in;
      2'd1: data_out = {data_in[DATA_W-2:0], data_in[DATA_W-1]};
      2'd2: data_out = ~data_in;
      default: data_out = '0;
    endcase
  end
endmodule
