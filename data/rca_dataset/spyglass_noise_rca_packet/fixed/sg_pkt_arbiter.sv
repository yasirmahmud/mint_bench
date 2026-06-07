module sg_pkt_arbiter #(
  parameter int DATA_W = 32
) (
  input  logic [DATA_W-1:0] a,
  input  logic [DATA_W-1:0] b,
  input  logic              sel,
  output logic [DATA_W-1:0] y
);
  always_comb begin
    y = sel ? b : a;
  end
endmodule

