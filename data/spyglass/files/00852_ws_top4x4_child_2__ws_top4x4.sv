module ws_top4x4 #(parameter depth=4, bit_width=8, acc_width=32, size=4) (
   clk,
   control,
   data_arr,
   wt_arr,
   acc_out
);

   input clk;
   input control; 
   input [(bit_width*depth)-1:0] data_arr;
   input [31:0] wt_arr;
   output reg [acc_width*size-1:0] acc_out;
   
   
   // Implement your logic below based on the MAC unit design in MAC.v
   // mac_wt_inX and mac_wt_out0, mac_wt_out1, mac_wt_out2 are used for weight propagation.
   // mac_wt_out3 is an unused output from the last column and removed.
   wire [(bit_width*depth)-1:0] mac_wt_in0, mac_wt_in1, mac_wt_in2, mac_wt_in3;
   wire [(bit_width*depth)-1:0] mac_wt_out0, mac_wt_out1, mac_wt_out2;
   
   // mac_data_in0 is the primary input, mac_data_outX propagate data horizontally.
   // mac_data_in1, mac_data_in2, mac_data_in3 are removed (unused)
   wire [(bit_width*depth)-1:0] mac_data_in0;
   wire [(bit_width*depth)-1:0] mac_data_out0, mac_data_out1, mac_data_out2, mac_data_out3;
   
   // mac_acc_inX are unused; acc_in ports are directly connected or 'h0, removed.
   wire [acc_width*size-1:0] mac_acc_out0, mac_acc_out1, mac_acc_out2, mac_acc_out3;
   
      
   assign mac_data_in0 = control ? 'h0 : data_arr; // pass the data when control bit is not set
   // Removed unused wire assignments for mac_data_in1, mac_data_in2, mac_data_in3
   
   assign mac_wt_in0 = control ? wt_arr : 'h0;
   assign mac_wt_in1 = control ? mac_wt_out0 : 'h0;
   assign mac_wt_in2 = control ? mac_wt_out1 : 'h0;
   assign mac_wt_in3 = control ? mac_wt_out2 : 'h0;
   
   
   // The commented line was already inactive, so no functional change here.
   // Removed: //assign mac_acc_in1 = mac_acc_out0;

   ws_pe4x4 u_MAC11 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_in0[7:0]),
      .wt_path_in  (mac_wt_in0[7:0]),
      .acc_in      ('h0),
      .data_out    (mac_data_out0[7:0]),
      .wt_path_out (mac_wt_out0[7:0]),
      .acc_out     (mac_acc_out0[acc_width-1:0])
   );
   ws_pe4x4 u_MAC12 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_in0[15:8]),
      .wt_path_in  (mac_wt_in1[7:0]),
      .acc_in      (mac_acc_out0[acc_width-1:0]),
      .data_out    (mac_data_out0[15:8]),
      .wt_path_out (mac_wt_out1[7:0]),
      .acc_out     (mac_acc_out1[acc_width-1:0])
   );
   ws_pe4x4 u_MAC13 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_in0[23:16]),
      .wt_path_in  (mac_wt_in2[7:0]),
      .acc_in      (mac_acc_out1[acc_width-1:0]),
      .data_out    (mac_data_out0[23:16]),
      .wt_path_out (mac_wt_out2[7:0]),
      .acc_out     (mac_acc_out2[acc_width-1:0])
   );
   ws_pe4x4 u_MAC14 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_in0[31:24]),
      .wt_path_in  (mac_wt_in3[7:0]),
      .acc_in      (mac_acc_out2[acc_width-1:0]),
      .data_out    (mac_data_out0[31:24]),
      .wt_path_out (), // mac_wt_out3 is unused, port left unconnected
      .acc_out     (mac_acc_out3[acc_width-1:0])
   );
   ws_pe4x4 u_MAC21 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out0[7:0]),
      .wt_path_in  (mac_wt_in0[15:8]),
      .acc_in      ('h0),
      .data_out    (mac_data_out1[7:0]),
      .wt_path_out (mac_wt_out0[15:8]),
      .acc_out     (mac_acc_out0[2*acc_width-1:acc_width])
   );
   ws_pe4x4 u_MAC22 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out0[15:8]),
      .wt_path_in  (mac_wt_in1[15:8]),
      .acc_in      (mac_acc_out0[2*acc_width-1:acc_width]),
      .data_out    (mac_data_out1[15:8]),
      .wt_path_out (mac_wt_out1[15:8]),
      .acc_out     (mac_acc_out1[2*acc_width-1:acc_width])
   );
   ws_pe4x4 u_MAC23 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out0[23:16]),
      .wt_path_in  (mac_wt_in2[15:8]),
      .acc_in      (mac_acc_out1[2*acc_width-1:acc_width]),
      .data_out    (mac_data_out1[23:16]),
      .wt_path_out (mac_wt_out2[15:8]),
      .acc_out     (mac_acc_out2[2*acc_width-1:acc_width])
   );
   ws_pe4x4 u_MAC24 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out0[31:24]),
      .wt_path_in  (mac_wt_in3[15:8]),
      .acc_in      (mac_acc_out2[2*acc_width-1:acc_width]),
      .data_out    (mac_data_out1[31:24]),
      .wt_path_out (), // mac_wt_out3 is unused, port left unconnected
      .acc_out     (mac_acc_out3[2*acc_width-1:acc_width])
   );
   
   ws_pe4x4 u_MAC31 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out1[7:0]),
      .wt_path_in  (mac_wt_in0[23:16]),
      .acc_in      ('h0),
      .data_out    (mac_data_out2[7:0]),
      .wt_path_out (mac_wt_out0[23:16]),
      .acc_out     (mac_acc_out0[3*acc_width-1:2*acc_width])
   );
   
   ws_pe4x4 u_MAC32 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out1[15:8]),
      .wt_path_in  (mac_wt_in1[23:16]),
      .acc_in      (mac_acc_out0[3*acc_width-1:2*acc_width]),
      .data_out    (mac_data_out2[15:8]),
      .wt_path_out (mac_wt_out1[23:16]),
      .acc_out     (mac_acc_out1[3*acc_width-1:2*acc_width])
   );
   
   ws_pe4x4 u_MAC33 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out1[23:16]),
      .wt_path_in  (mac_wt_in2[23:16]),
      .acc_in      (mac_acc_out1[3*acc_width-1:2*acc_width]),
      .data_out    (mac_data_out2[23:16]),
      .wt_path_out (mac_wt_out2[23:16]),
      .acc_out     (mac_acc_out2[3*acc_width-1:2*acc_width])
   );
   
   ws_pe4x4 u_MAC34 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out1[31:24]),      // Corrected from mac_data_in0 to mac_data_out1 for data propagation
      .wt_path_in  (mac_wt_in3[23:16]),
      .acc_in      (mac_acc_out2[3*acc_width-1:2*acc_width]),
      .data_out    (mac_data_out2[31:24]),
      .wt_path_out (), // mac_wt_out3 is unused, port left unconnected
      .acc_out     (mac_acc_out3[3*acc_width-1:2*acc_width])
   );
   
   
   ws_pe4x4 u_MAC41 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out2[7:0]),
      .wt_path_in  (mac_wt_in0[31:24]),
      .acc_in      ('h0),
      .data_out    (mac_data_out3[7:0]),
      .wt_path_out (mac_wt_out0[31:24]),
      .acc_out     (mac_acc_out0[4*acc_width-1:3*acc_width])
   );
   ws_pe4x4 u_MAC42 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out2[15:8]),
      .wt_path_in  (mac_wt_in1[31:24]),
      .acc_in      (mac_acc_out0[4*acc_width-1:3*acc_width]),
      .data_out    (mac_data_out3[15:8]),
      .wt_path_out (mac_wt_out1[31:24]),
      .acc_out     (mac_acc_out1[4*acc_width-1:3*acc_width])
   );
   ws_pe4x4 u_MAC43 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out2[23:16]),
      .wt_path_in  (mac_wt_in2[31:24]),
      .acc_in      (mac_acc_out1[4*acc_width-1:3*acc_width]),
      .data_out    (mac_data_out3[23:16]),
      .wt_path_out (mac_wt_out2[31:24]),
      .acc_out     (mac_acc_out2[4*acc_width-1:3*acc_width])
   );
   ws_pe4x4 u_MAC44 (
      .clk         (clk),
      .control     (control),
      .data_in     (mac_data_out2[31:24]), // Corrected from mac_data_in1 to mac_data_out2 for data propagation
      .wt_path_in  (mac_wt_in3[31:24]),
      .acc_in      (mac_acc_out2[4*acc_width-1:3*acc_width]),
      .data_out    (mac_data_out3[31:24]),
      .wt_path_out (), // mac_wt_out3 is unused, port left unconnected
      .acc_out     (mac_acc_out3[4*acc_width-1:3*acc_width])
   );
 
  

   always@(posedge clk) begin
      acc_out <= mac_acc_out3;
   end

endmodule
