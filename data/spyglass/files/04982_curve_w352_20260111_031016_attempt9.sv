module curve_w352_20260111_031016_attempt9 ();

  initial begin
    integer i;
    // Rule W352: The 'for' condition is constant - the loop will either never execute or never terminate.
    // Here, the condition (i == i) is always true, causing the loop to never terminate.
    // This triggers W352 because the loop condition is constant.
    // The use of 'i' in the condition (i == i) is intended to prevent W481a (step variable not used in condition)
    // which was observed in previous attempts. 'i' is also used in initialization and increment.
    for (i = 0; (i == i); i = i + 1) begin
      // An empty loop body is used to be minimal and avoid introducing other rules.
    end
  end

endmodule
