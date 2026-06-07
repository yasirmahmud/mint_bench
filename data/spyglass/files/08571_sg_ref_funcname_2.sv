module funcname_violation_ex2(input in_a, output out_b);
function integer MyFunc(input integer val);
begin MyFunc = val;
end endfunction assign out_b = MyFunc(in_a);
endmodule
