module curve_w426_20260111_101958_attempt5 (
    input wire in_a,
    input wire in_b,
    output reg out_c
);

  // SpyGlass Rule W426: Global variable 'out_c' should not be 'set' in task
  task update_output_c;
    // This single assignment directly modifies 'out_c', a global variable
    // (declared outside the task). This is expected to trigger exactly one W426 violation.
    out_c = in_a & in_b;
  endtask

  always @* begin
    update_output_c; // Call the task
  end

endmodule
