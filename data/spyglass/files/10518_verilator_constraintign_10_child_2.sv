module verilator_constraintign_10_child_2 (
  input clk,
  input rst_n,
  output reg [3:0] s
);

  // Wire to hold the next value of 's'
  wire [3:0] s_next;

  // Combinational logic: Determine the next state of 's'
  always_comb begin
    if (s == 4'd9) begin
      s_next = 4'd0;
    end else begin
      s_next = s + 4'd1;
    end
  end

  // Sequential logic: Update 's' on clock edge or reset
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s <= 4'd0;
    end else begin
      s <= s_next;
    end
  end

endmodule
