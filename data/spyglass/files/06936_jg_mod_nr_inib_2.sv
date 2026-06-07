module another_initial_test (
  output reg [7:0] data_config
);
  initial begin
    data_config = 8'h5A; // Initial blocks are not synthesizable
  end
endmodule
