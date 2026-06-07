module curve_synth_5036_20260110_153204_attempt1 (
    input wire [7:0] in1,
    input wire [7:0] in2,
    output reg [7:0] out_data
);

  // Function where the violation occurs
  function automatic [7:0] my_sum_function (input [7:0] a, input [7:0] b);
    begin
      // SYNTH_5036 violation: Non-blocking assignment to a function's return value
      // This assignment will be treated as blocking during synthesis.
      my_sum_function <= a + b;
    end
  endfunction

  // Use the function to ensure all inputs/outputs are utilized
  always @(*) begin
    out_data = my_sum_function(in1, in2);
  end

endmodule
