module rule_1_3_ex1 (input primary_in, output primary_out);
 (* _sec_pin_type="pad" *) wire my_output_pad;
 assign my_output_pad = primary_in;
 assign primary_out = 1'b0;
 endmodule
