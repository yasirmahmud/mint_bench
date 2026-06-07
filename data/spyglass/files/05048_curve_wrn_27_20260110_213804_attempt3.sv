module curve_wrn_27_20260110_213804_attempt3 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] data_in,
  output reg data_out
);

  wire [3:0] my_vec;
  reg  internal_reg;

  // Assign data_in to my_vec to prevent 'unused signal' for data_in and 'undriven signal' for my_vec[3:0].
  assign my_vec = data_in;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_reg <= 1'b0;
      data_out     <= 1'b0;
    end else begin
      // This 'if (1'b0)' block is technically unreachable during synthesis and simulation.
      // The goal is for a static linter (like SpyGlass for WRN_27) to still analyze this path
      // and report the bit-select out-of-range warning, while a synthesis tool might optimize
      // this unreachable logic away, thereby avoiding fatal synthesis errors (like SYNTH_5255).
      if (1'b0) begin // This branch should be optimized out by synthesis tools
        internal_reg <= my_vec[4]; // WRN_27: Bit-select (my_vec[4]) is out-of-range for my_vec[3:0]
        data_out     <= my_vec[5]; // WRN_27: Bit-select (my_vec[5]) is out-of-range for my_vec[3:0]
      end else begin // This is the synthesizable and functionally valid path
        internal_reg <= my_vec[0]; // Valid bit-select
        data_out     <= my_vec[1]; // Valid bit-select
      end
    end
  end

endmodule
