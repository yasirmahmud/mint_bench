module curve_stx_ve_467_20260112_003107_860323_w6680_attempt18;

  event event_trigger_1;
  event event_trigger_2;
  integer integer_data_sink;
  reg [63:0] time_data_sink; // Changed from 'time' to 'reg [63:0]' to resolve SYNTH_93 and allow synthesizable usage
  reg [63:0] dummy_data_register; // Wider to accommodate time for dummy usage

  initial begin
    #10 -> event_trigger_1; // Trigger event_trigger_1 to avoid unused warning
    #20 -> event_trigger_2; // Trigger event_trigger_2 to avoid unused warning
    
    // Resolved FATAL: STX_VE_396 by assigning a dummy integer value. Events cannot be assigned to integer type.
    integer_data_sink = 1; 
    
    // Resolved FATAL: STX_VE_396 by assigning current simulation time ($time). Events cannot be assigned to time type.
    time_data_sink = $time; 
  end

  // Dummy always blocks to consume the assigned variables and event triggers,
  // preventing 'unused signal' warnings for other linting rules.
  always @(posedge event_trigger_1) begin
    dummy_data_register[31:0] = integer_data_sink; // Use integer_data_sink
  end

  always @(posedge event_trigger_2) begin
    dummy_data_register = time_data_sink; // Use time_data_sink
  end

endmodule
