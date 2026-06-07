module detect_array_03 (
  input logic clk,
  input logic rst_n
);
  typedef struct packed { logic [7:0] data; } item_t;
  logic item_t items [0:1];

  // Break the combinational loop by introducing a register for items[0].
  // items[0] now captures the value of items[1] from the previous clock cycle.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      items[0] <= '{default: '0};
    end else begin
      items[0] <= items[1];
    end
  end

  // items[1] is combinatorially driven by the current (registered) value of items[0].
  // This completes a sequential feedback loop: items[0] (registered) -> items[1] (combinatorial) -> items[0] (registered input).
  always_comb begin
    items[1] = items[0];
  end
endmodule
