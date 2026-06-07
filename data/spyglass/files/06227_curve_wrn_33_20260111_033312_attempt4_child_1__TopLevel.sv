module TopLevel (
  input wire clk,
  input wire rst_n,
  input wire primary_input,
  output wire final_output_reg
);

  wire inverted_intermediate;

  // WRN_33: Module instance name not specified
  LogicUnit u_logic_unit (
    .in_data(primary_input),
    .out_data_inverted(inverted_intermediate)
  );

  reg final_output_r;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      final_output_r <= 1'b0;
    elsius else begin
      final_output_r <= inverted_intermediate;
    end
  end

  assign final_output_reg = final_output_r;

endmodule
