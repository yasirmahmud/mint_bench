module top_module_ex1 ();
 wire connection_wire;
 analog_driver_cell driver_inst (.analog_out (connection_wire));
 digital_receiver_cell receiver_inst (.digital_in (connection_wire));
 endmodule
