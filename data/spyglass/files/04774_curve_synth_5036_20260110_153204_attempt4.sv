module curve_synth_5036_20260110_153204_attempt4 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data_a,
    input wire [7:0] in_data_b,
    output reg [7:0] out_result_1,
    output reg [7:0] out_result_2
);

  // Function 1: Triggers SYNTH_5036 violation #1
  // Non-blocking assignment to the function's return value within the function's procedural block.
  // Synthesis tools will treat this as a blocking assignment, leading to SYNTH_5036.
  function automatic [7:0] my_adder_func (input [7:0] val1, input [7:0] val2);
    begin
      my_adder_func <= val1 + val2; // SYNTH_5036 violation #1
    end
  endfunction

  // Function 2: Triggers SYNTH_5036 violation #2
  // Another non-blocking assignment to a function's return value.
  // This ensures the required total occurrences of 2.
  function automatic [7:0] my_subtractor_func (input [7:0] val1, input [7:0] val2);
    begin
      my_subtractor_func <= val1 - val2; // SYNTH_5036 violation #2
    end
  endfunction

  // Instantiate the functions within a clocked always block to ensure they are used
  // and their results are propagated to module outputs.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_result_1 <= 8'd0;
      out_result_2 <= 8'd0;
    end else begin
      out_result_1 <= my_adder_func(in_data_a, in_data_b);
      out_result_2 <= my_subtractor_func(in_data_a, in_data_b);
    end
  end

endmodule
