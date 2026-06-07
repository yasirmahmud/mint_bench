module example2 (
    output reg done
);

task my_simple_task;
    begin
        done = 1'b1;
    end
endtask

initial begin
    #1;
    my_simple_task;
    #10;
    disable my_simple_task; // Non-synthesizable disable
end

endmodule
