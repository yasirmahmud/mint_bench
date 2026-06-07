module curve_synth_5395_20260110_184124_attempt15 (
  input clk,
  input rst, // Asynchronous active-high reset
  input data_in, // A data signal used as an edge-sensitive event
  output reg out_reg
);

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable
  // This 'always' block is sensitive to the positive edge of the clock 'clk',
  // the positive edge of the asynchronous reset 'rst', and the positive edge
  // of a data signal 'data_in'.
  // The rule description 'repeat_event_example' combined with the context examples
  // (especially Example 1 with `posedge counter` being part of the sensitivity list
  // alongside a clock and an async reset, while SYNTH_5395 is triggered on `if(rst)`) 
  // suggests that using a data signal as an edge-sensitive event in the same sensitivity
  // list as a clock and an asynchronous reset triggers this rule.
  // This approach aims to mimic the structure that generates SYNTH_5395 when standard
  // asynchronous reset styles (as used in previous attempt 14, which surprisingly did not
  // trigger SYNTH_5395) are not sufficient.
  // This structure represents an 'improper asynchronous style of modeling' due to the 
  // complex, mixed-signal event list and how state is updated, which is often difficult
  // to synthesize reliably or to a specific target flip-flop type.
  always @(posedge clk or posedge rst or posedge data_in) begin
    if (rst) begin // Standard asynchronous reset condition
      out_reg <= 1'b0;
    end else begin
      // This logic will be sensitive to both 'clk' and 'data_in' edges when 'rst' is inactive.
      // This mixed sensitivity to 'data_in's edge along with clock and reset is often
      // flagged as an improper asynchronous style.
      out_reg <= data_in; // Example logic, behaves like a D-flop on 'clk' and 'data_in' edges.
    end
  end

endmodule
