module w422_ex2(input clk1, input clk2, input data_in, output reg data_out);
  // Original design had an 'always' block sensitive to two independent clock edges (clk1 and clk2).
  // This construct is unsynthesizable and violates SpyGlass rules W422 and STARC05-2.3.3.1.
  // To resolve these violations, an 'always' block must be sensitive to only one clock edge.
  // This typically implies that the output register must be clocked by a single, well-defined clock.
  // As an expert RTL engineer, the most common and synthesizable fix for such a scenario,
  // while aiming to preserve functional intent where a single register is influenced by multiple clocks,
  // is to designate one clock as the primary clock for the output register.
  // Data from other clock domains would typically require synchronization, which is an architectural change
  // beyond simply fixing the linting violation of the sensitivity list.
  // By selecting 'clk1' as the clock for 'data_out', the linting violations are resolved,
  // but the direct influence of 'clk2' on 'data_out' is removed.
  // This is the most direct fix to the linting rules that makes the code synthesizable.
  always @(posedge clk1) begin
    data_out <= data_in;
  end
endmodule
