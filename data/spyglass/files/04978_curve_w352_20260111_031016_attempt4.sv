module curve_w352_20260111_031016_attempt4;

  reg [7:0] i; // Declare 'i' as an 8-bit unsigned register

  initial begin
    // W352: The 'for' condition 'i >= 0' is constant.
    // Since 'i' is an 8-bit unsigned register, its value is always non-negative (0 to 255).
    // Therefore, the condition 'i >= 0' is always true, making it a constant condition.
    // The loop will never terminate (infinite loop).
    // This triggers W352: "The 'for' condition is constant - the loop will either never execute or never terminate".
    //
    // This example aims to avoid W481a (Possibly unsynthesizable loop: step variable 'i' is not used in condition) 
    // because the step variable 'i' IS explicitly used in the condition ('i >= 0').
    for (i = 0; i >= 0; i = i + 1) begin
      // The loop body is empty for minimality. The variable 'i' is used in the loop definition.
    end
  end

endmodule
