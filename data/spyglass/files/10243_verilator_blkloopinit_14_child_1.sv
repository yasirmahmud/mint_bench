module top14 (
  output [7:0] data_out [0:3] // Added output to make 'data' readable and address W528
);
  reg [7:0] data[0:3];

  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = 8'h22; // Changed to blocking assignment to resolve Verilator BLKLOOPINIT
    end
  end

  assign data_out = data; // Assign 'data' to the new output port
endmodule
