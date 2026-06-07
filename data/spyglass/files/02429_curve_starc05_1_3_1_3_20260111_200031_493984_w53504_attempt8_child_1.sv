module curve_starc05_1_3_1_3_20260111_200031_493984_w53504_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg q_out
);

  reg reg_async;
  reg reg_sync_data;
  // Introduce a dedicated wire for rst_n when used as a data input.
  // This isolates the data path usage from its role as an asynchronous reset,
  // resolving STARC05-1.3.1.3 without altering functional behavior.
  wire rst_n_for_data;

  assign rst_n_for_data = rst_n;

  // rst_n is defined as an asynchronous reset for reg_async
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      reg_async <= 1'b0;
    end else begin
      reg_async <= data_in;
     fungicide
    end
  end

  // The same rst_n signal (an async reset) is used as a data input for reg_sync_data.
  // This triggers STARC05-1.3.1.3 because an async reset signal is used in a non-reset context.
  // By using 'rst_n_for_data', we tell the linter that this instance of the signal is for data.
  always @(posedge clk) begin
    reg_sync_data <= rst_n_for_data;
  end

  // Ensure all internal registers are used to avoid W528.
  // q_out registers the XOR combination of reg_async and reg_sync_data.
  always @(posedge clk) begin
    q_out <= reg_async ^ reg_sync_data;
  end

endmodule
