module Data_Memory(
	input clk, rst,
	input [31:0] A,
	input [31:0] WD,
	input WE,
	output [31:0] RD
);

// create the memory
reg [31:0] mem [1023:0];

assign RD = (!WE) ? mem[A] : 32'h0000_0000; // This is not following the clock 

initial begin
        mem[28] = 32'h00000020;
        //mem[40] = 32'h00000002;
end

always @(posedge clk) begin 

if(WE) begin
	
	mem[A] <= WD;

end


end



endmodule
