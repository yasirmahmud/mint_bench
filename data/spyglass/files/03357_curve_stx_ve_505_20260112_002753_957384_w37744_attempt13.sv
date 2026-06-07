module curve_stx_ve_505_20260112_002753_957384_w37744_attempt13 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare a task to demonstrate the violation inside its body.
  task my_processing_task;
    input [7:0] in_data;
    output reg [7:0] out_data;
    begin
      // STX_VE_505 violation: `end_keywords is placed inside a design element (a task).
      // This directive must only be specified outside of any module, program, interface, or other design elements.
      `end_keywords
      out_data = in_data + 8'd1; // Simple operation to use data and avoid other warnings
    end
  endtask

  // Instantiate the task to ensure it is used and avoid unused task warnings
  always @(*) begin
    my_processing_task(data_in, data_out);
  end

endmodule
