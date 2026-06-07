module two_digit_counter_ssg  (
  input clock,
    input reset,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp,
    output [3:0]an
    );

  
reg [3:0]first; //register for the first digit
reg [3:0]second; //register for the second digit

// Wires for next-state logic to resolve STARC05-2.11.3.1 violations
wire [3:0] first_next;
wire [3:0] second_next;

reg [10:0] delay; //register to produce the 0.1 second delay
wire test;

always @ (posedge clock or posedge reset)
 begin
  if (reset)
   delay <= 0;
  else
   delay <= delay + 1;
 end
 
assign test = &delay; //AND each bit of delay with itself; test will be high only when all bits of delay are high

// Combinational logic for the next state of first and second counters
always @ (*) begin
  first_next = first;
  second_next = second;

  if (test) begin
    if (first == 4'd9) begin  // x9 reached
      first_next = 0;
      if (second == 4'd9) begin // 99 reached
        second_next = 0;
      end else begin
        second_next = second + 1;
      end
    end else begin
      first_next = first + 1;
    end
  end
end

// Sequential logic to update the first and second counters
always @ (posedge clock or posedge reset)
begin
  if (reset) begin
   first <= 0;
   second <= 0;
  end
  else begin
   first <= first_next;
   second <= second_next;
  end
end
  
//Multiplexing circuit below

localparam N = 7;

reg [N-1:0]count;

always @ (posedge clock or posedge reset)
 begin
  if (reset)
   count <= 0;
  else
   count <= count + 1;
 end

// Changed sseg width to 4 bits to match BCD digits and resolve W263 violations.
// '4'd10' will be used as the code for a dash symbol.
reg [3:0]sseg;
reg [3:0]an_temp;
always @ (*)
 begin
  case(count[N-1:N-2])
   
   2'b00 : 
    begin
     sseg = first;
     an_temp = 4'b1110;
    end
   
   2'b01:
    begin
     sseg = second;
     an_temp = 4'b1101;
    end
   
   2'b10:
    begin
     sseg = 4'd10; // Use 4'd10 as code to produce '-' (dash symbol)
     an_temp = 4'b1011;
    end
    
   2'b11:
    begin
     sseg = 4'd10; // Use 4'd10 as code to produce '-' (dash symbol)
     an_temp = 4'b0111;
    end
   default: begin // Add default for exhaustive case statement
     sseg = 4'bxxxx;
     an_temp = 4'bxxxx;
   end
  endcase
 end
assign an = an_temp;

reg [6:0] sseg_temp; 
always @ (*)
 begin
  // Case selector 'sseg' and labels (4'd0-4'd9) now have matching widths (4 bits),
  // resolving W263 violations. The default case handles 4'd10 for the dash.
  case(sseg)
   4'd0 : sseg_temp = 7'b1000000; //0
   4'd1 : sseg_temp = 7'b1111001; //1
   4'd2 : sseg_temp = 7'b0100100; //2
   4'd3 : sseg_temp = 7'b0110000; //3
   4'd4 : sseg_temp = 7'b0011001; //4
   4'd5 : sseg_temp = 7'b0010010; //5
   4'd6 : sseg_temp = 7'b0000010; //6
   4'd7 : sseg_temp = 7'b1111000; //7
   4'd8 : sseg_temp = 7'b0000000; //8
   4'd9 : sseg_temp = 7'b0010000; //9
   default : sseg_temp = 7'b0111111; //dash (handles 4'd10 or any other unlisted value)
  endcase
 end
assign {g, f, e, d, c, b, a} = sseg_temp; 
assign dp = test; //we dont need the decimal here so turn all of them off (flickering dot based on test signal)



endmodule
