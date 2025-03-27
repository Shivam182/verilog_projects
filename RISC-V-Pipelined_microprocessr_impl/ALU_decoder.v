module ALU_decoder(
	input [1:0] ALUop, // This comes from the main decoder of control unit 
	output [2:0] ALU_control,
	input [6:0] op_code, func7,
	input [2:0] func3
);	
	
wire [1:0] concatenation;
assign concatenation = {op_code, func7};

assign ALU_control = (ALUop == 2'b00) ? 3'b000:
			(ALUop == 2'b01) ? 3'b001:
			   ((ALUop == 2'b10) & (func3 == 3'b010)) ? 3'b101:
				((ALUop == 2'b10) & (func3 == 3'b110)) ? 3'b011:
					((ALUop == 2'b10) & (ALUop == 3'b111)) ? 3'b010:
						((ALUop == 2'b10) & (ALUop == 3'b111) & (concatenation == 2'b11)) ? 3'b001:
						     ((ALUop == 2'b10) & (ALUop == 3'b111) & (concatenation != 2'b11)) ? 3'b000 : 3'b000;



endmodule
