module casex_example_18(
  input [3:0] data_in_bus,
  output reg [2:0] data_out_bus
);
  always @* begin
    casex (data_in_bus)
      4'hX: data_out_bus = 3'b000;
      4'h1: data_out_bus = 3'b001;
      4'h2: data_out_bus = 3'b010;
      default: data_out_bus = 3'b111;
    endcase
  end
endmodule
