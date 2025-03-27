module Instruction_memory(
	input [31:0] A, // Single i/p port that takes 32 bit address and maps to a location in instruction memory.
	output [31:0] RD, // Single o/p port that returns an instruction of 32-bit saved in specific location. 
	input reset // Resets the instruction memory
);

reg [31:0] mem [1023:0]; // Creating the memory

assign RD = (reset == 1'b0) ? 32'h0000_0000 : mem[A[31:2]]; // The address at its i/p A is updated by the program counter.

initial begin
    $readmemh("instructions_file_input.hex",mem);
end

endmodule
