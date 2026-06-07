module w392_ex2(y1, y2, data1, data2, enable, preset, clear);
 input data1, data2, enable, preset, clear;
 output y1, y2;
 reg y1, y2;
 always @(enable or clear or preset or data1) begin if (clear) y1 = 0;
 else if (preset) y1 = 1;
 else if (enable) y1 = data1;
 end always @(enable or clear or preset or data2) begin if (clear) y2 = 0;
 else if (!preset) y2 = 1;
 else if (enable) y2 = data2;
 end endmodule
