module IIR_Filter(
	input clk, rst,
	input [3:0] a, x,
	output [3:0] y
);

reg [3:0] y_val;
wire [7:0] baugh_prod_res;

signed_multiplier BWSM(.A(a), .B(y_val), .P(baugh_prod_res));

always @(posedge clk, rst, x, a) begin 

	if(rst) begin

		y_val <= x;
	end 
	else begin 

		y_val <= x + baugh_prod_res[3:0];

	end


end

assign y = y_val;

endmodule