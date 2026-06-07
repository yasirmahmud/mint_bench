module curve_synth_132_20260111_183938_083763_w7792_attempt10 (
  input wire clk,
  input wire rst_n,
  output wire [15:0] overall_data_out
);

  wire [7:0] sub_data_1, sub_data_2, sub_data_3, sub_data_4, sub_data_5, sub_data_6;

  sub_module u_sub_inst_1 (.clk_i(clk), .rst_n_i(rst_n), .data_o(sub_data_1));
  sub_module u_sub_inst_2 (.clk_i(clk), .rst_n_i(rst_n), .data_o(sub_data_2));
  sub_module u_sub_inst_3 (.clk_i(clk), .rst_n_i(rst_n), .data_o(sub_data_3));
  sub_module u_sub_inst_4 (.clk_i(clk), .rst_n_i(rst_n), .data_o(sub_data_4));
  sub_module u_sub_inst_5 (.clk_i(clk), .rst_n_i(rst_n), .data_o(sub_data_5));
  sub_module u_sub_inst_6 (.clk_i(clk), .rst_n_i(rst_n), .data_o(sub_data_6));

  // SYNTH_132 Violations: Hierarchical references to module parameters are not supported for synthesis
  // when used in constant expressions like localparam declarations.
  localparam P_SIZE_1 = u_sub_inst_1.WIDTH_PARAM + 1; // Violation #1
  localparam P_SIZE_2 = u_sub_inst_2.WIDTH_PARAM + 2; // Violation #2
  localparam P_SIZE_3 = u_sub_inst_3.WIDTH_PARAM + 3; // Violation #3
  localparam P_SIZE_4 = u_sub_inst_4.WIDTH_PARAM + 4; // Violation #4
  localparam P_SIZE_5 = u_sub_inst_5.WIDTH_PARAM + 5; // Violation #5
  localparam P_SIZE_6 = u_sub_inst_6.WIDTH_PARAM + 6; // Violation #6

  // These localparams are used for register declarations to avoid unused warnings.
  reg [P_SIZE_1-1:0] reg_a;
  reg [P_SIZE_2-1:0] reg_b;
  reg [P_SIZE_3-1:0] reg_c;
  reg [P_SIZE_4-1:0] reg_d;
  reg [P_SIZE_5-1:0] reg_e;
  reg [P_SIZE_6-1:0] reg_f;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      reg_a <= {P_SIZE_1{1'b0}};
      reg_b <= {P_SIZE_2{1'b0}};
      reg_c <= {P_SIZE_3{1'b0}};
      reg_d <= {P_SIZE_4{1'b0}};
      reg_e <= {P_SIZE_5{1'b0}};
      reg_f <= {P_SIZE_6{1'b0}};
    end else begin
      reg_a <= reg_a + sub_data_1[0];
      reg_b <= reg_b + sub_data_2[0];
      reg_c <= reg_c + sub_data_3[0];
      reg_d <= reg_d + sub_data_4[0];
      reg_e <= reg_e + sub_data_5[0];
      reg_f <= reg_f + sub_data_6[0];
    end
  end

  assign overall_data_out = {sub_data_1[7:0], sub_data_2[7:0]};

endmodule
