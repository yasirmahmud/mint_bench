module incomplete_case_16;
  reg [3:0] fsm_state;
  reg fsm_output;
  always @* begin
    case (fsm_state)
      4'd0: fsm_output = 1'b0;
      4'd1: fsm_output = 1'b1;
      4'd2: fsm_output = 1'b0;
      4'd3: fsm_output = 1'b1;
      4'd4: fsm_output = 1'b0;
      4'd5: fsm_output = 1'b1;
      4'd6: fsm_output = 1'b0;
      4'd7: fsm_output = 1'b1;
      4'd8: fsm_output = 1'b0;
      4'd9: fsm_output = 1'b1;
    endcase
  end
endmodule
