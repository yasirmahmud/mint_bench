module MultipleWait_ex1;
reg clk;
reg data;
initial begin clk=0;
data=0;
#5 clk=1;
#5 clk=0;
#5 clk=1;
wait(clk);
data=1;
wait(clk);
data=0;
#5 $finish;
end endmodule
