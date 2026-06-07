module CELL_TYPE_MEM #(parameter PARAM_HAS_INIT=0, parameter PARAM_MEM_DEPTH=2, parameter PARAM_MEM_WIDTH=2)(input PORT_ID_CLK, input PORT_ID_WEN, input [$clog2(PARAM_MEM_DEPTH) - 1 : 0] PORT_ID_RADDR, input [$clog2(PARAM_MEM_DEPTH) - 1 : 0] PORT_ID_WADDR, input [PARAM_MEM_WIDTH - 1 : 0] PORT_ID_WDATA, output [PARAM_MEM_WIDTH - 1 : 0] PORT_ID_RDATA);
   reg [PARAM_MEM_WIDTH -  1 : 0] data_array [0 : PARAM_MEM_DEPTH - 1];
   always @(posedge PORT_ID_CLK) begin
      if (PORT_ID_WEN) begin
         data_array[PORT_ID_WADDR] = PORT_ID_WDATA;
      end
   end
   assign PORT_ID_RDATA = data_array[PORT_ID_RADDR];
endmodule
