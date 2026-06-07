module CheckAnalogConnection_ex1;
 wire net_ana_dig;
 ANA_MACRO i_ana (.PO(net_ana_dig));
 DIGITAL_CELL i_dig (.A(net_ana_dig));
 endmodule
