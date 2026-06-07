module simple_mux (
    input i0,
    input i1,
    input sel,
    output out_data
);
    assign out_data = sel ? i1 : i0;
endmodule
