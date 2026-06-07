module day13(
  input wire clk,
  input wire reset,
  
  input wire[3:0] parallel_in,
  output wire serial_o,
  output wire empty_o,
  output wire valid_o
);

  reg [3:0] shift_data;
wire [3:0] next;

// shift register to shift data on clk
always@(posedge clk or posedge reset)
  begin
    if(reset)
      	shift_data <= 4'h0;
    else
      shift_data <= next;
  end

//To take parallel input if empty, else shift left serially  to output 
assign next = empty_o? parallel_in : {shift_data[2:0],1'b0};
assign serial_o = shift_data[3];


//counter to generate valid and empty signal
reg [2:0] count_reg;
wire [2:0] next_count;

      
always@(posedge clk or posedge reset)
  begin
    if(reset)
      count_reg<=3'h0;
    else
      count_reg<=next_count;
  end

//count goes to zero once all data goes out i.e. at count=4
assign next_count= (count_reg==3'h4)?3'h0:count_reg +3'h1 ;

// empty goes high when count_reg=0
assign empty_o = (count_reg==3'h0);

//valid=1 till count is not equal to zero
   assign valid_o = valid_o | count_reg;

endmodule
