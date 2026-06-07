module STARC02_2_1_10_12_ex1 (input in_data, input enable, output out_data);
  
  reg out_data_latch;

  // Model the behavior of trireg and tranif1 using a synthesizable latch.
  // When 'enable' is high, 'out_data' tracks 'in_data'.
  // When 'enable' is low, 'out_data' holds its last value.
  always @(*) begin
    if (enable) begin
      out_data_latch = in_data;
    end
    // Implicitly, when enable is low, out_data_latch holds its current value,
    // modeling the 'trireg' behavior of retaining the last driven value.
  end

  // Connect the internal latch output to the module output port.
  assign out_data = out_data_latch;

endmodule
