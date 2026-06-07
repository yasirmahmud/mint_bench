interface another_interface_no_modport;
  logic req;
  logic ack;
  logic [15:0] addr;
  logic [31:0] wdata;
  logic [31:0] rdata;
endinterface

module processor_no_modport (
  input logic sys_clk,
  input logic sys_reset,
  another_interface_no_modport bus_intf
);
  always_ff @(posedge sys_clk or posedge sys_reset) begin
    if (sys_reset) begin
      bus_intf.req <= 1'b0;
      bus_intf.addr <= '0;
      bus_intf.wdata <= '0;
    end else begin
      bus_intf.req <= 1'b1;
      bus_intf.addr <= 16'h1000;
      bus_intf.wdata <= 32'hDEADBEEF;
    end
  end

  logic [31:0] received_data;
  assign received_data = bus_intf.rdata;

endmodule
