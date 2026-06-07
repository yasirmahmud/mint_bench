module internal_sub_module (
    input wire sub_in,
    output wire sub_out
);
    assign sub_out = sub_in;
endmodule // This 'endmodule' closes 'internal_sub_module'.
