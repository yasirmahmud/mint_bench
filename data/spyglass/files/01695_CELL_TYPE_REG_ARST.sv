module CELL_TYPE_REG_ARST #(parameter PARAM_CLK_POSEDGE=1, parameter PARAM_ARST_POSEDGE=1, parameter PARAM_INIT_VALUE=0, parameter PARAM_WIDTH=1)(input PORT_ID_ARST, input PORT_ID_CLK, input [PARAM_WIDTH - 1 : 0] PORT_ID_IN, output [PARAM_WIDTH - 1 : 0] PORT_ID_OUT);
   reg [PARAM_WIDTH - 1 : 0] data;
   initial begin
      data = PARAM_INIT_VALUE;
   end
   wire true_clk;
   assign true_clk = PARAM_CLK_POSEDGE ? PORT_ID_CLK : ~PORT_ID_CLK;
   wire true_rst;
   assign true_rst = PARAM_ARST_POSEDGE ? PORT_ID_ARST : ~PORT_ID_ARST;
   always @(posedge true_clk or posedge true_rst) begin
      if (true_rst) begin
         data <= PARAM_INIT_VALUE;
      end else begin
         data <= PORT_ID_IN;
      end
   end
   assign PORT_ID_OUT = data;
endmodule
