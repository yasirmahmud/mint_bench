module duplicate_port_module_1 (
  input wire clk,
  input wire rst,
  output reg data,
  input wire clk // Duplicate port 'clk'
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    data <= 1'b0;
  end else begin
    data <= ~data;
  end
end

endmodule
