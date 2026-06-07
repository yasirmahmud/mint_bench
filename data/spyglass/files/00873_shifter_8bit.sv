module shifter_8bit #(parameter WIDTH = 8) (
  input [WIDTH-1 : 0] d_in,
  input [2:0] op,
  input clk, capture,
  output [WIDTH-1 : 0] d_out
);

 
  // Intermediate wire carrying the multiplexer output
  wire [WIDTH-1:0] mux_out;
  
  wire [WIDTH-1:0] d_hold = d_out;
 
  // wire carrying 0-7 outputs from compute to mux
  wire [WIDTH-1:0] out0;
  wire [WIDTH-1:0] out1;
  wire [WIDTH-1:0] out2;
  wire [WIDTH-1:0] out3;
  wire [WIDTH-1:0] out4;
  wire [WIDTH-1:0] out5;
  wire [WIDTH-1:0] out6;
  wire [WIDTH-1:0] out7;
 
    // Instantiate the compute
  compute #(WIDTH) com_inst (
      .d_in(d_in),
      .d_hold(d_hold),
      .op0(out0),
      .op1(out1),
      .op2(out2),
      .op3(out3),
      .op4(out4),
      .op5(out5),
      .op6(out6),
      .op7(out7)
  );
 
    // Instantiate the mux selector.
  mux #(WIDTH) mux_inst (
      .in0(out0),
      .in1(out1),
      .in2(out2),
      .in3(out3),
      .in4(out4),
      .in5(out5),
      .in6(out6),
      .in7(out7),
      .op(op),
      .y(mux_out)
  );
 
  // Instantiate the register module (built from 8 DFFs):
  // It loads the mux result on the rising edge when capture==0.
  register #(WIDTH) reg_inst(
      .d(mux_out),
      .clk(clk),
      .capture(capture),
      .q(d_out)
  );
 
endmodule
