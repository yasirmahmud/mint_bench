module curve_w481a_20260111_185503_557821_w37940_attempt6;

  reg stop_flag;
  integer i;

  initial begin
    stop_flag = 1'b0;
    // The loop step variable 'i' is incremented, but the loop condition '!stop_flag'
    // does not depend on 'i'. This directly triggers the W481a violation.
    // The 'stop_flag' is modified inside the loop based on 'i', ensuring the loop
    // can terminate and preventing the W352 (constant true end condition) violation.
    for (i = 0; !stop_flag; i = i + 1) begin
      if (i > 5) begin
        stop_flag = 1'b1;
      end
    end
  end

endmodule
