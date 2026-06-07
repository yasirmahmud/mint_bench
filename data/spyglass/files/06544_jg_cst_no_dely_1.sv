module NonConstantDelay1;
  reg [7:0] data_in;
  wire [7:0] data_out;
  reg [3:0] delay_val; // This will be the non-constant delay

  initial begin
    data_in = 8'hAA;
    delay_val = 5;
    #10;
    delay_val = 2;
    #10;
    data_in = 8'h55;
  end

  assign #(delay_val) data_out = data_in; // Violation: delay_val is not a constant expression
endmodule
