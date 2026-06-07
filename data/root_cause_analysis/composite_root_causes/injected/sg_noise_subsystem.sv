module sg_noise_subsystem #(
  parameter int WIDTH = 32,
  parameter int DATA_W = 32
) (
  input  logic [WIDTH-1:0] payload_in,
  input  logic [1:0]        route_sel,
  output logic [WIDTH-1:0] payload_out
);
  logic [WIDTH-1:0] p1;
  logic [WIDTH-1:0] p2;
  logic [WIDTH-1:0] p3;
  logic [WIDTH-1:0] p4;

  sg_noise_router #(
    .DATA_W(DATA_W)
  ) u_router (
    .data_in(payload_in),
    .sel(route_sel),
    .data_out(p1)
  );

  sg_noise_checksum #(
    .DATA_W(DATA_W)
  ) u_checksum (
    .data_in(p1),
    .data_out(p2)
  );

  sg_noise_status #(
    .DATA_W(DATA_W)
  ) u_status (
    .data_in(p2),
    .status_out(p3)
  );

  sg_noise_arbiter #(
    .DATA_W(DATA_W)
  ) u_arbiter (
    .a(p2),
    .b(p3),
    .sel(route_sel[0]),
    .y(p4)
  );

  always_comb payload_out = p4;
endmodule
