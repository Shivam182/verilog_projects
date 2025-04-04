module ALU(
       input [31:0] A, B,
       output [31:0] result, 
       output carry, overflow, zero, negative,
       input [3:0] ALU_control // It signifies 8 different operations 
);



wire [31:0] a_and_b; // logical AND op
wire [31:0] a_or_b; // logical OR op
wire [31:0] not_b;
wire [31:0] mux_response;

wire [31:0] mux_2;

wire [31:0] sum; // addition + subtraction

wire slt; // zero extension

// Flags 

wire cout; // carryout flag

//wire z; // zero flag

//wire n; // negative flag

//wire carry; // carry flag

//wire v; // overflow flag: Occurs when operands of same sign but result of different sign



assign a_and_b = A & B;
assign a_or_b = A | B;
assign not_b = ~B;


assign mux_response = (ALU_control[0] == 1'b0) ? B : not_b;


assign {cout,sum} = A + mux_response + ALU_control[0]; // As the zeroth bit of the ALU control will be differentiating b/w sum and diff.

assign mux_2 = (ALU_control[2:0] == 3'b000)? sum:
		(ALU_control[2:0] == 3'b001)? sum:
		  (ALU_control[2:0] == 3'b010)?  a_and_b:
		    (ALU_control[2:0] == 3'b011) ? a_or_b:
		      (ALU_control[2:0] == 3'b100) ? slt : 32'h0000_0000; //100 specifies a strange operation


assign z = &(~A); // reduction operator on negated bits of Accumulator will give value of zero flag.

assign n = result[31];

assign carry = cout & (~ALU_control[1]); // ALU[1] is zero for sum and diff operations for whom carry makes sense



// Consider case of overflow:: The below logic is equivalent to 3-XOR gate overflow detection
// A[31] xor sum[31] checks if they r of distinct sign then it resolves to 1.
// A[31] xor B[31] checks if two operands r of same sign then it reolves to 0 further xor with ALU[0] results in 0 and finally negated it becomes 1.
// 1 and 1 and 1 results in True for overflow flag.
assign v = (~ALU_control[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALU_control[0])); // overflow makes sense only for sum and diff so we use ALU[1]


// Search what slt does actually in ALUs
assign slt = {31'b0000000000000000000000000000000, sum[31]}; 

endmodule
