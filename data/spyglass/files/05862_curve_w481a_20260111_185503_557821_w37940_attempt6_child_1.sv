module curve_w481a_20260111_185503_557821_w37940_attempt6;

  reg stop_flag;
  integer i;

  initial begin
    stop_flag = 1'b0;
    // The loop step variable 'i' is incremented, and is now directly part of the loop condition
    // along with '!stop_flag', addressing the W481a violation.
    // 'stop_flag' is modified inside the loop based on 'i' and used in the condition,
    // which resolves W528 as 'stop_flag' is now explicitly read and written.
    // The SYNTH_5143 violation for the initial block is expected as it describes simulation-only behavior.
    for (i = 0; !stop_flag && i <= 6; i = i + 1) begin
      if (i > 5) begin
        stop_flag = 1'b1;
      end
    end
  end

endmodule
