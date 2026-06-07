module pwm_generator(input clk, rst, input [2:0] pwm_in, output reg pwm_out);

reg [2:0] counter;

always@(posedge clk or posedge rst) // Added rst to sensitivity list for asynchronous reset
begin
  if (rst) begin
    counter <= 3'b0; // Resolved W336 (blocking assignment) and SYNTH_5143 (initial block)
    pwm_out <= 1'b0; // Good practice to reset output register
  end else begin
    // PWM output logic based on current 'counter' value
    if(pwm_in >= counter) begin
      pwm_out <= 1'b1; // Resolved W336 (blocking assignment)
    end else begin
      pwm_out <= 1'b0; // Resolved W336 (blocking assignment)
    end

    // Counter update logic to cycle 0, 1, ..., 6, then back to 0
    // This ensures 'counter' is assigned only once, resolving W415a and W336
    if (counter == 3'b110) begin // If current counter is 6 (max value before reset)
      counter <= 3'b0; // Reset to 0 in the next cycle
    end else begin
      counter <= counter + 1; // Increment for other values
    end
  end
end

endmodule
