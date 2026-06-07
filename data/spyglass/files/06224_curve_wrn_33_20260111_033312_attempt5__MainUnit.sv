module MainUnit (
  input wire clk,
  input wire reset_n,
  input wire data_in_x,
  input wire data_in_y,
  output wire result_out_z
);

  wire xor_result_wire;

  // WRN_33: Module instance name not specified
  SubBlock (
    .in_a(data_in_x),
    .in_b(data_in_y),
    .out_xor(xor_result_wire)
  );

  reg result_reg;
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      result_reg <= 1'b0;
    end else begin
      result_reg <= xor_result_wire;
    end
  end

  assign result_out_z = result_reg;

endmodule
