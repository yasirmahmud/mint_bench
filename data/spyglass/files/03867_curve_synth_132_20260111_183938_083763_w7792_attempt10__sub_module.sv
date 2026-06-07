module sub_module (
  input wire clk_i,
  input wire rst_n_i,
  output reg [7:0] data_o
);
  parameter WIDTH_PARAM = 8;

  reg [WIDTH_PARAM-1:0] counter_internal;

  always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      counter_internal <= {WIDTH_PARAM{1'b0}};
      data_o <= {8{1'b0}};
    end else begin
      counter_internal <= counter_internal + 1;
      data_o <= counter_internal;
    end
  end
endmodule
