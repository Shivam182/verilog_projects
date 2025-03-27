module Single_cycle_top_tb(
	
);


reg clk = 1'b1;
reg rst;


Single_Cycle_Top(
	.clk(clk),
	.rst(rst)
);


always begin 

clk = ~clk;
#50;

end




initial begin 

rst <= 0;
#150;


rst <= 1;
#650;

$finish;


end



endmodule