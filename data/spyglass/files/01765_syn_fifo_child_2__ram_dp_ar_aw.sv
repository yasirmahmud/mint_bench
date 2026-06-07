module ram_dp_ar_aw #(
  parameter DATA_WIDTH = 72,
  parameter ADDR_WIDTH = 3
) (
  input clk,
  input [ADDR_WIDTH-1:0] address_0,
  input [DATA_WIDTH-1:0] data_0,
  input cs_0,
  input we_0,
  // Removed oe_0 as it was unused for port 0 (write port)

  input [ADDR_WIDTH-1:0] address_1,
  output [DATA_WIDTH-1:0] data_1,
  input cs_1,
  // Removed we_1 as it was unused for port 1 (read port)
  input oe_1
);

  localparam RAM_DEPTH = (1 << ADDR_WIDTH);
  reg [DATA_WIDTH-1:0] mem [0 : RAM_DEPTH-1];
  reg [DATA_WIDTH-1:0] read_data_reg_1;

  // Write Port (Port 0)
  always @(posedge clk) begin
    if (cs_0 && we_0) begin
      mem[address_0] <= data_0;
    end
  end

  // Read Port (Port 1)
  always @(posedge clk) begin
    if (cs_1 && oe_1) begin // Assuming oe_1 acts as read enable
      read_data_reg_1 <= mem[address_1];
    }
  end

  assign data_1 = read_data_reg_1; // Registered output

endmodule
