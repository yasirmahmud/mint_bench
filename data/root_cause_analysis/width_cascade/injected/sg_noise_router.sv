module sg_noise_router #(
  parameter int DATA_W = 32
) (
  input  logic [DATA_W-1:0] data_in,
  input  logic [1:0]        sel,
  output logic [DATA_W-1:0] data_out
);
  always_comb begin
    unique case (sel)
      2'd0: data_out = data_in;
      2'd1: data_out = {data_in[7:0], data_in[DATA_W-1:8]};
      2'd2: data_out = data_in ^ {DATA_W{1'b1}};
      default: data_out = '0;
    endcase
  end
endmodule
