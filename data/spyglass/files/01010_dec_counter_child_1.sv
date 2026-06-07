module dec_counter
  (/*AUTOARG*/
  // Outputs
  expired, counter,
  // Inputs
  clk, rst, load, load_value
  );

  input        clk;
  input        rst; // Active-low reset
  input        load;
  input [23:0] load_value;

  output        expired;
  output [24:0] counter; // This is a registered output

  /*AUTOREG*/
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg			expired;
  // End of automatics
  /*AUTOWIRE*/

  //regs
  reg [24:0]   counter;
  reg          counter_d; // Register for previous MSB

  // Wires for next state calculation of counter and counter_d
  wire [24:0] next_counter_val;
  wire        next_counter_d_val;

  // Combinational logic to determine the next state of counter and counter_d
  // This always block computes the inputs for the 'counter' and 'counter_d' registers
  always @* begin
    // Default assignments: values remain the same unless conditions below change them
    next_counter_val = counter;
    next_counter_d_val = counter_d; // Will be updated if load or decrement logic applies

    if (load == 1'b1) begin
      next_counter_val = {1'b0, load_value};
      next_counter_d_val = 1'b0; // MSB is 0 after load
    end
    else begin
      // 'counter_d' captures the MSB of 'counter' *before* the current clock edge's update.
      // So, 'next_counter_d_val' is set to the current 'counter[24]' value.
      next_counter_d_val = counter[24];
      if (counter[24] == 1'b0) begin
        next_counter_val = counter - 1;
      end
      // If counter[24] == 1'b1, next_counter_val remains 'counter' (default assignment handles this)
    end
  end

  // Sequential logic for counter and counter_d registers
  always @(posedge clk) begin
    if (rst == 1'b0) begin // Active-low reset
      counter <= 25'h1ffffff; // All ones, MSB is 1
      counter_d <= 1'b1;     // Previous MSB was 1, so no expiration at reset
    end
    else begin // Not in reset
      counter <= next_counter_val;
      counter_d <= next_counter_d_val;
    end
  end

  // Sequential logic for expired flag
  always @(posedge clk) begin
    if (~rst) begin // Active-low reset
      expired <= 1'b0;
    end
    else begin
      // Assert expired when counter[24] transitions from 0 to 1
      // counter[24] is the current MSB, counter_d is the previous MSB
      expired <= (counter[24] == 1'b1) && (counter[24] != counter_d);
    end
  end

endmodule
