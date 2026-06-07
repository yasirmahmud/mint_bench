module curve_w442a_20260111_194906_276303_w37940_attempt7 (
    input clk,
    input rst_n,
    input d_in,
    output reg q_out
);

  // This 'always' block is sensitive to both posedge clk and negedge rst_n.
  // The first statement inside the always block is an 'if' statement,
  // but it checks a synchronous condition ('d_in'), not the asynchronous reset ('rst_n').
  // The SpyGlass rule W442a, "Asynchronously reset/set always block has missing 'if' statement at the top level",
  // is interpreted here as meaning the top-level 'if' statement must specifically handle the asynchronous condition.
  // Since 'if (d_in)' is present instead of 'if (!rst_n)' (or equivalent) as the primary condition,
  // the asynchronous reset 'rst_n' is not correctly prioritized or handled at the top level.
  // 'q_out' is assigned in both branches to prevent the inference of a latch.
  always @(posedge clk or negedge rst_n) begin
    if (d_in) begin // The first 'if' statement checks a synchronous condition, not the asynchronous reset.
      q_out <= 1'b1;
    end else begin
      q_out <= 1'b0;
    end
  end

endmodule
