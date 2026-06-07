module cordic_gain #(
  parameter gp_mode_rot_vec = 0,
  parameter gp_gain_width   = 12,
  parameter gp_xy_width     = 8,
  parameter gp_xy_owidth    = gp_xy_width+$clog2(gp_gain_width)
) (
  input  wire signed [gp_xy_width-1 :0] i_cordic_x,
  input  wire signed [gp_xy_width-1 :0] i_cordic_y,
  output wire signed [gp_xy_owidth-1:0] o_cordic_x,
  output wire signed [gp_xy_owidth-1:0] o_cordic_y
);

// -------------------------------------------------------------------
  localparam c_1_gain = $rtoi( 0.607252959138945 * (2.0**(gp_gain_width-1)) );
  wire signed [gp_xy_width+gp_gain_width-1:0] x_tmp;
  wire signed [gp_xy_width+gp_gain_width-1:0] y_tmp;
// -------------------------------------------------------------------  
  assign x_tmp = i_cordic_x * c_1_gain;
	
  if (gp_mode_rot_vec)
    begin	    	    
      assign y_tmp = i_cordic_x * c_1_gain;
    end
  else
    begin
      assign y_tmp = 'd0;
    end	

  // OUTPUT ASSIGNMENT
  assign o_cordic_x = x_tmp >>> (gp_gain_width-1);    
  assign o_cordic_y = y_tmp >>> (gp_gain_width-1);
endmodule
