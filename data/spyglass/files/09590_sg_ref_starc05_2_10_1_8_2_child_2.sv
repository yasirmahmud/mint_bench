module star_ex2(input [1:0] addr, output reg [3:0] case_out);
reg [3:0] my_ram [0:3];

initial begin
  integer i;
  // Initialize all elements of my_ram to a known state (e.g., all zeros)
  for (i = 0; i < 4; i = i + 1) begin
    my_ram[i] = 4'b0000;
  end
end

wire [3:0] ram_out;
assign ram_out = my_ram[addr];
always @(*) begin
  case (ram_out)
    4'b0000: case_out = 4'b0001;
    default: case_out = 4'b0000;
  endcase
end
endmodule
