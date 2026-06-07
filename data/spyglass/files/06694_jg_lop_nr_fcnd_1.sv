module loop_never_runs_for_example (
  input wire clk,
  input wire rst,
  output reg [7:0] count
);

  integer i;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      count <= 8'd0;
    end else begin
      for (i = 10; i < 5; i = i + 1) begin // Loop condition (i < 5) is false from start
        count <= count + 1;
      end
    end
  end

endmodule
