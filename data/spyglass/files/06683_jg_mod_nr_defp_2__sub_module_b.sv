module sub_module_b (
  input wire enable,
  output reg [0:0] status
);
  parameter INITIAL_STATE = 1'b0;

  initial begin
    status = INITIAL_STATE;
  end

  always @(enable) begin
    if (enable) begin
      status <= ~status;
    end
  end
endmodule
