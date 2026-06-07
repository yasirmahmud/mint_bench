module curve_synth_5143_20260111_201639_145003_w37940_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out
);

  // Synthesizable logic: A simple D-flip-flop with asynchronous reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // SYNTH_5143: Initial block is ignored for synthesis
  // This block explicitly triggers the target rule.
  // It uses simulation-only constructs (fork/join, $info) to ensure
  // no other synthesis-related issues are introduced.
  initial begin
    fork
      $info("[%t] Module %m: Initial simulation phase 1 started.", $time);
      #10 $info("[%t] Module %m: Initial simulation phase 2 after 10 time units.", $time);
    join
    $info("[%t] Module %m: Initial block simulation tasks completed.", $time);
  end

endmodule
