module sg_mroot_subsys_c #(
  parameter int DATA_W = 32
) (
  output logic signature
);
  // ROOT CAUSE C: BUS_W should be DATA_W (32), but is incorrectly set to DATA_W - 4.
  // This creates 5 stage instances * 2 mismatched ports each = 10 dependent W110 violations.
  localparam int BUS_W = DATA_W - 4;

  logic [BUS_W-1:0] p0;
  logic [BUS_W-1:0] p1;
  logic [BUS_W-1:0] p2;
  logic [BUS_W-1:0] p3;
  logic [BUS_W-1:0] p4;
  logic [BUS_W-1:0] p5;

  sg_mroot_stage #(.DATA_W(DATA_W)) u_stage0 (.data_in(p0), .data_out(p1));
  sg_mroot_stage #(.DATA_W(DATA_W)) u_stage1 (.data_in(p1), .data_out(p2));
  sg_mroot_stage #(.DATA_W(DATA_W)) u_stage2 (.data_in(p2), .data_out(p3));
  sg_mroot_stage #(.DATA_W(DATA_W)) u_stage3 (.data_in(p3), .data_out(p4));
  sg_mroot_stage #(.DATA_W(DATA_W)) u_stage4 (.data_in(p4), .data_out(p5));

  always_comb begin
    p0 = {BUS_W{1'b1}};
    signature = ^p5;
  end
endmodule

