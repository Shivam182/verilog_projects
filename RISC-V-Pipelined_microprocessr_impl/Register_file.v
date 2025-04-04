// Memory block of 32 * 32
// Contains 3 address input ports and two read ports 
// addresses at first two ports will send data to two read ports and address at third port will be used to write registers.
// There r 32 different register locations so addresses will be of 5 bit max.

module register_file(
	input [4:0] A1, A2, A3,
	input clk, rst,
	input [31:0] WD3, // 32bit input data that needs to be written
	input WE3, // Write enable signal
	output [31:0] RD1, RD2
);

// Create the memory 
reg [31:0] mem [31:0];


assign RD1 = (!rst) ? 32'h0000_0000 : mem[A1];
assign RD2 = (!rst) ? 32'h0000_0000 : mem[A2];

initial begin
        mem[5] = 32'h00000005;
        mem[6] = 32'h00000004;
        
end

always @(posedge clk) begin 

if(WE3) begin 

	mem[A3] <= WD3;


end


end

endmodule
