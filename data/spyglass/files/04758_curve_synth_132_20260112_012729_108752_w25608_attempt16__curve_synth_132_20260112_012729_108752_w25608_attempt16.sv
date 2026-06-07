module curve_synth_132_20260112_012729_108752_w25608_attempt16 (
  input wire clk,
  input wire rst_n,
  output wire dummy_out
);

  // Instantiate the sub-module. Its parameter 'TEST_VALUE' will be referenced.
  // We set TEST_VALUE to 25 for this example.
  param_source_module #(.TEST_VALUE(25)) u_param_source;

  // Internal signal to connect the logic generated within the 'generate' block
  // to the main module's output, ensuring all paths are driven.
  wire internal_generated_output;

  // SYNTH_132 Violation: Hierarchical references to module parameters are not
  // supported for synthesis when used in 'generate if' conditions.
  // The condition 'u_param_source.TEST_VALUE > 20' attempts to access a parameter
  // from an instantiated module at elaboration time, which violates SYNTH_132.
  generate
    if (u_param_source.TEST_VALUE > 20) begin : gen_condition_true
      // This block will be instantiated because TEST_VALUE (25) is greater than 20.
      reg [3:0] counter;

      always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          counter <= 4'h0; // Reset counter
        end else begin
          counter <= counter + 4'h1; // Increment counter
        end
      end
      // Drive the internal output with a part of the counter value.
      assign internal_generated_output = counter[0];
    end else begin : gen_condition_false
      // This branch will not be instantiated given TEST_VALUE is 25.
      // It's included for completeness within the generate construct, ensuring
      // 'internal_generated_output' is defined within the generate block structure.
      assign internal_generated_output = 1'b0;
    end
  endgenerate

  // Connect the internal generated output to the main module's output port.
  assign dummy_out = internal_generated_output;

endmodule
