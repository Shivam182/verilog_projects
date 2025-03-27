module program_cntr(
	input rst, clk,
	input [31:0] PC_NEXT, // next instruction address 
	output reg [31:0] PC // current address
);


always @(posedge clk) begin 

if(!rst) begin 
	PC <= 32'h0000_0000;
end else begin 

	PC <= PC_NEXT;
end


end


endmodule
