module sub_module (
    input wire actual_input_port,
    output reg actual_output_port
  );
    always @(*) begin
      actual_output_port = actual_input_port; // Simple combinational logic
    end
  endmodule
