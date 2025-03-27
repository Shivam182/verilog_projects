module flop_synchronizer #(parameter WDTH = 3)(
	input clk,
	input rstn,
	input [WDTH:0] addr,
	
	output reg [WDTH:0] out_addr // denotes the second flip-flop
);

reg [WDTH:0] q1;

always @(posedge clk) begin 

	if(!rstn) begin   
	
	   q1 <= 0;
	   out_addr <= 0;

	end else begin 

	   q1 <= addr;
	   out_addr <= q1;

	end
end
endmodule