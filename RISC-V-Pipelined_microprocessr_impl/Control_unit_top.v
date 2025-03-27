module Control_unit_top(
    input [6:0]Op,funct7,
    input [2:0]funct3,
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,
    output [1:0]ImmSrc,
    output [2:0]ALUControl
);

Main_decoder main_decoder(
		.op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUop(ALUOp)
);

ALU_decoder alu_decoder(
			    .ALUop(ALUOp),
                            .func3(funct3),
                            .func7(funct7),
                            .op5(Op),
                            .ALU_control(ALUControl)
);
    


endmodule
