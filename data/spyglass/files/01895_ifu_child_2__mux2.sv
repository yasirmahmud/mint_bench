module mux2 (output out, input in0, input in1, input sel);
    assign out = sel ? in1 : in0;
endmodule
