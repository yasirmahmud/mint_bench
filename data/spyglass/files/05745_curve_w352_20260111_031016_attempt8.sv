module curve_w352_20260111_031016_attempt8 ();

  initial begin
    integer i;
    // The 'for' loop condition (1 == 0) is a constant expression.
    // It always evaluates to '0' (false), meaning the loop will never execute.
    // This triggers W352: "The 'for' condition is constant - the loop will either never execute or never terminate".
    for (i = 0; (1 == 0); i = i + 1) begin
      // Minimal empty loop body.
    end
  end

endmodule
