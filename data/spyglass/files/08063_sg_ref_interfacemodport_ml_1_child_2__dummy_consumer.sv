module dummy_consumer(input wire dummy_signal);
  // This module does nothing, it just consumes the input signal
  // to prevent 'set but not read' warnings for intentionally unused signals.
endmodule
