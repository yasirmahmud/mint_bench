module sub_module (
    output dummy_out // Added dummy port to satisfy "empty definition" warning
);
    // This dummy output does not affect the functional behavior of my_func
    assign dummy_out = 1'b0;

    function integer my_func;
        input integer a;
        begin
            my_func = a + 1;
        end
    endfunction
endmodule
