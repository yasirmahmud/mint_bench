module top19 (
  output my_struct_t data[0:3]
);
  typedef struct { logic [7:0] val; } my_struct_t;
  initial begin
    for (int i = 0; i < 4; i++) begin
      // Change 2: Use blocking assignment to resolve Verilator BLKLOOPINIT warning.
      data[i].val = 8'h77;
    end
  end
endmodule
