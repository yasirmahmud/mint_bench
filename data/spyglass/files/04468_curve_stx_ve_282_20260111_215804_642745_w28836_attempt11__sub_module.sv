module sub_module (
    input wire s_in,
    output reg s_out
  );
    always @(*) begin
      s_out = s_in; // Simple combinational logic to avoid latches and unused signals
    end
  endmodule
