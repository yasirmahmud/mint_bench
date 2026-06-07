module dec_counter
  (/*AUTOARG*/
  // Outputs
  expired, counter,
  // Inputs
  clk, rst, load, load_value
  );

  input        clk;
  input        rst;
  input        load;
  input [23:0] load_value;

  output        expired;
  output [24:0] counter;

  /*AUTOREG*/
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg			expired;
  // End of automatics
  /*AUTOWIRE*/

  //regs
  reg [24:0]   counter;
  reg          counter_d;

  always @(posedge clk) begin
    if (rst == 1'b0) begin
      counter <= 25'h1ffffff;
      counter_d <= 1'b1;
    end
    else begin
      if (load == 1'b1) begin
	counter <= {1'b0, load_value};
	counter_d <= 1'b0;
      end
      else begin
	counter_d <= counter[24];
	if (counter[24] == 1'b0) begin
	  counter <= counter - 1;
	end
	else begin
	  counter <= counter;
	end
      end
    end
  end

  always @(posedge clk) begin
    if (~rst) begin
      expired <= 1'b0;
    end
    else begin
      expired = counter[24] == 1'b1 & counter[24] != counter_d;
    end
  end

endmodule
