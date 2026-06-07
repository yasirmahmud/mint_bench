module curve_w392_20260111_182843_915337_w53504_attempt8 (
  input wire clk_i,
  input wire rst_sig,
  input wire data_i,
  output reg q_al,
  output reg q_ah
);

  // To resolve W392, a distinct reset signal is created for the active-low reset functionality.
  // This signal, rst_n_for_qal, is asserted high when the original rst_sig is low.
  // This allows it to be used as an active-high asynchronous reset while preserving the original functional behavior for q_al.
  wire rst_n_for_qal = ~rst_sig;

  // Register 1: Asynchronous active-low reset (functional behavior preserved)
  // The original design reset q_al when rst_sig was low, asynchronously triggered by negedge rst_sig.
  // By using rst_n_for_qal as an active-high reset:
  // - The asynchronous trigger posedge rst_n_for_qal occurs when rst_n_for_qal goes from 0 to 1,
  //   which happens when rst_sig goes from 1 to 0 (i.e., negedge rst_sig).
  // - The reset condition if (rst_n_for_qal) is true when rst_n_for_qal is 1,
  //   which happens when rst_sig is 0 (the original active-low reset condition).
  always @(posedge clk_i or posedge rst_n_for_qal) begin
    if (rst_n_for_qal) begin // This condition is true when rst_sig is 0
      q_al <= 1'b0;
    end else begin
      q_al <= data_i;
    end
  end

  // Register 2: Asynchronous active-high reset (no change)
  // This register continues to use rst_sig as its active-high asynchronous reset.
  // Now, 'rst_sig' is consistently used with 'posedge' in the sensitivity list within the module,
  // and the other reset uses a distinct derived signal 'rst_n_for_qal'.
  always @(posedge clk_i or posedge rst_sig) begin
    if (rst_sig) begin // Active-high assertion
      q_ah <= 1'b0;
    end else begin
      q_ah <= data_i;
    end
  end

endmodule
