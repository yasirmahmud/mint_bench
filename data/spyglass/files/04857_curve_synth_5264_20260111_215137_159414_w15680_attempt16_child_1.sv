module curve_synth_5264_20260111_215137_159414_w15680_attempt16 (
  input real temperature_sensor
);
  real internal_temperature_value;

  // Reading the input to prevent W240 violation
  // This operation is not synthesizable due to 'real' type
  always @* begin
    internal_temperature_value = temperature_sensor;
  end
  
  // Rule SYNTH_5264 (Net type 'REAL' is not supported) is expected to be triggered
  // by the declaration of an input port with the 'real' data type, 
  // as 'real' is not synthesizable.
endmodule
