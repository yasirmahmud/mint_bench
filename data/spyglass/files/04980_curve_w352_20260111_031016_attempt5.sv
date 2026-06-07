module curve_w352_20260111_031016_attempt5;

  integer i; // Declare 'i' as an integer to avoid W480

  initial begin
    // W352: The 'for' condition is constant - the loop will either never execute or never terminate.
    // The condition '(i == i)' is always true, regardless of 'i's value, making it a constant condition.
    // This will cause the loop to never terminate, directly triggering W352.
    //
    // Distinctiveness and rule avoidance:
    // - Using 'integer i' prevents W480 ('Loop index 'i' is not of type integer').
    // - The condition '(i == i)' uses the step variable 'i', which is intended to prevent W481a
    //   ('Possibly unsynthesizable loop: step variable 'i' is not used in condition').
    // - This condition is distinct from the literal constants ('1' or '1'b1') used in context examples.
    for (i = 0; (i == i); i = i + 1) begin
      // Minimal empty loop body.
    end
  end

endmodule
