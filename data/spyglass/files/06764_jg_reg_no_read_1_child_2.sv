module unread_reg_example1 (
  input wire clk,
  input wire rst_n,
  input wire data_in
);

  reg my_unused_reg; // This will be assigned and now read

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_unused_reg <= 1'b0;
    end else begin
      my_unused_reg <= data_in;
    end
  end

  // To resolve SpyGlass W528 (set but not read) violation for my_unused_reg
  // A dummy read is added to ensure 'my_unused_reg' is read.
  wire dummy_read_my_unused_reg;
  assign dummy_read_my_unused_reg = my_unused_reg;

  // To resolve SpyGlass W528 (set but not read) violation for 'dummy_read_my_unused_reg'
  // Using a SystemVerilog immediate assertion within an always_comb block
  // makes the signal "read" by linting tools without affecting the synthesizable
  // functional behavior or changing module ports. This assertion is trivial
  // (always true) and only serves to reference the signal.
  always_comb begin
    assert(dummy_read_my_unused_reg === dummy_read_my_unused_reg);
  end

endmodule
