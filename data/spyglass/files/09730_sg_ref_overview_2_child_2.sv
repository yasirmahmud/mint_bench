module netlist_tag_ex2 (
    output wire (* spyglass_tag = "my_tag" *) a
);
 assign a = 1'b0;
 endmodule
