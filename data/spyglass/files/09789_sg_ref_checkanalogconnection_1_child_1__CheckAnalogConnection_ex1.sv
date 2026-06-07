module CheckAnalogConnection_ex1;
 wire net_ana_dig;
 wire unused_z;
 ANA_MACRO i_ana (.PO(net_ana_dig));
 DIGITAL_CELL i_dig (.A(net_ana_dig), .Z(unused_z));
 endmodule
