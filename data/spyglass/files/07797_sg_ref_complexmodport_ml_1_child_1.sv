interface my_interface_ex1;
 logic [1:0] data_a;
 logic [1:0] data_b;
 logic [3:0] combined_data;
 modport master ( output data_a, output data_b );
 endinterface
