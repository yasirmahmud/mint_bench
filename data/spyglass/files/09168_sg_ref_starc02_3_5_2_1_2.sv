module starc02_3_5_2_1_ex2;
 integer fd;
 initial begin fd = $fopen("/absolute/path/to/file.txt", "w");
 if (fd) $fclose(fd);
 end endmodule
