module IIR_Filter_tb;

reg clk, rst;
reg [3:0] a, x;
wire [3:0] y;

IIR_Filter iirF(
	.clk(clk),
	.rst(rst),
	.a(a),
	.x(x),
	.y(y)
);

initial begin

   clk = 0;

end

always
	#5 clk = !clk;
initial begin 

	rst = 1;
	a = 4'd2;
	x = 4'd1;
	#10 rst = 0;
	
	a = 4'd2;
	x = 4'd1;

	#10;

        a = 4'd1;
        x = 4'd4;
        #10;

end

initial begin 
        $monitor("Time=%0t | rst=%b a=%d x=%d | y=%d", $time, rst, a, x, y);
end



endmodule
