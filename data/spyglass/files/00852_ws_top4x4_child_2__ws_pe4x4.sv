module ws_pe4x4 #(parameter bit_width=8, acc_width=32) (
   clk,
   control,
   data_in,
   wt_path_in,
   acc_in,
   data_out,
   wt_path_out,
   acc_out
);

   input clk;
   input control; 
   input [bit_width-1:0] data_in;
   input [bit_width-1:0] wt_path_in;
   input [acc_width-1:0] acc_in;
   output reg [bit_width-1:0] data_out;
   output reg [bit_width-1:0] wt_path_out;
   output reg [acc_width-1:0] acc_out;

   // Pipelined registers for data and weights
   reg [bit_width-1:0] data_reg;
   reg [bit_width-1:0] wt_path_reg;

   // MAC operation: Multiply
   // The product can be up to (2*bit_width)-1 bits wide.
   wire [(bit_width*2)-1:0] product_unextended;
   assign product_unextended = data_in * wt_path_in;

   // Extend product to acc_width. Assuming unsigned multiplication for simplicity.
   // If signed, appropriate sign extension would be needed. For a generic MAC,
   // zero-extension is typical if signedness is not specified.
   wire [acc_width-1:0] product_extended = product_unextended;

   // MAC operation: Accumulate
   wire [acc_width-1:0] next_acc_val = acc_in + product_extended;

   // Pipelined register for accumulation result
   reg [acc_width-1:0] acc_reg;

   always @(posedge clk) begin
      // These registers pipeline the inputs and the accumulated value.
      // The 'control' input to the PE module is passed, but its effect on
      // conditional propagation/accumulation is handled by the parent module's
      // input gating (setting data_in or wt_path_in to 'h0) or is a higher-level
      // design decision not detailed for the inner PE functionality.
      data_reg      <= data_in;
      wt_path_reg   <= wt_path_in;
      acc_reg       <= next_acc_val;
   end

   // Assign outputs from pipeline registers
   assign data_out    = data_reg;
   assign wt_path_out = wt_path_reg;
   assign acc_out     = acc_reg;

endmodule
