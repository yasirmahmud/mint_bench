module curve_stx_ve_467_20260112_003107_860323_w6680_attempt18;

  event event_trigger_1;
  event event_trigger_2;
  integer integer_data_sink;
  time time_data_sink;
  reg [63:0] dummy_data_register; // Wider to accommodate time for dummy usage

  initial begin
    #10 -> event_trigger_1; // Trigger event_trigger_1 to avoid unused warning
    #20 -> event_trigger_2; // Trigger event_trigger_2 to avoid unused warning
    
    // FATAL: STX_VE_467 (1/2) - Non-equivalent data types in assignment operation.
    // Attempting to assign an 'event' handle to an 'integer' type.
    // Event handles are synchronization objects, not data values that can be stored as integers.
    integer_data_sink = event_trigger_1; // Violation 1: event to integer
    
    // FATAL: STX_VE_467 (2/2) - Non-equivalent data types in assignment operation.
    // Attempting to assign an 'event' handle to a 'time' type.
    // Event handles are synchronization objects, not data values that can be stored as time.
    time_data_sink = event_trigger_2; // Violation 2: event to time
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
