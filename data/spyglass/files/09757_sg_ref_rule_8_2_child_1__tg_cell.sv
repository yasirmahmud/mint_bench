module tg_cell (output out, input in, ctrl, ctrl_n);
 assign out = ctrl ? in : 1'bz;
 endmodule
