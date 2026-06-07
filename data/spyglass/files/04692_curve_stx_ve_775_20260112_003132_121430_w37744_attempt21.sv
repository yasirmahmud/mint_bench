module curve_stx_ve_775_20260112_003132_121430_w37744_attempt21 (
  input wire clk,
  input wire reset_n
);

  reg [7:0] data_a;
  reg [7:0] data_b;

  // This 'always' block defines a continuous procedural process.
  // An 'initial' block defines a one-time execution procedural process
  // and is not allowed to be nested within an 'always' block's scope.
  always @(posedge clk or negedge reset_n) begin
    // STX_VE_775: Initial statement not allowed in this scope. (Occurrence 1)
    initial begin
      $display("Violation 1: Initial block inside an always block.");
      data_a <= 8'hAA; // Using non-blocking to prevent potential multiple driver issues with blocking
    end

    // STX_VE_775: Initial statement not allowed in this scope. (Occurrence 2)
    initial begin
      $display("Violation 2: Another initial block inside an always block.");
      data_b <= 8'hBB;
    end

    if (!reset_n) begin
      data_a <= 8'h00;
      data_b <= 8'h00;
    end else begin
      data_a <= data_a + 1;
      data_b <= data_b + 2; // Unique update to ensure both signals are 'used'
    end
  end

endmodule
