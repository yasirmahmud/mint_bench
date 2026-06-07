module dlock  (unlock, b_in, clear, clk);

  input clk,clear,b_in;
  output reg unlock;
  reg [2:0] ps,ns;
  parameter s0 =3'b000;
  parameter s1 =3'b001;
  parameter s2 =3'b010;
  parameter s3 =3'b011;
  parameter s4 =3'b100;
  parameter s5 =3'b101;
  parameter s6 =3'b110;
  
  always@(negedge clk,negedge clear) begin
    if( !clear)
      		ps=s0;
    else
      		ps=ns;
  end
  
  always@(b_in,ps) begin
 case (ps)
     
      s0: begin ns=(b_in)?s1:s0;
      			unlock = 0;
      end
      s1:begin ns =(!b_in)?s2:s1;
      		   unlock= 0;
      end
      s2:begin 
        ns=(b_in)?s3:s0;
        unlock=0; 
      end
      s3:begin
        ns=(b_in) ?s4:s2;
        unlock=0;
      end
      s4:begin
        ns=(!b_in)?s5:s1;
        unlock =0;
      end
      s5:begin
        ns=(!b_in) ?s0:s3;
        unlock=(!b_in) ?1:0;
      end
      default: begin ns= s0; unlock = 0; end
          endcase
        
  end

  
endmodule
