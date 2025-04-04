module Single_Cycle_Top(
	input clk, rst
);

wire [31:0] PC_op, 
	    RD_instr,
	    RD_instr_op,
	    Imm_ext_op,
	    PcPlus4,
	    Result,
	    RD1_op,
	    RD2_op,
	    ALU_result,
	    ReadData,
	    SrcB;

wire RegWrite, MemWrite, ALUSrc, ResultSrc;

wire [2:0] ALU_control_op;
wire [1:0] ImmSrc;

program_cntr PC(
	.clk(clk),
	.rst(rst),
	.PC(PC_op),
	.PC_NEXT(PcPlus4)
);


PC_adder pc_adder(
	.a(PC_op),
	.b(32'd4),
	.c(PcPlus4)
);


Instruction_memory(
	.reset(rst),
	.A(PC_op),
	.RD(RD_instr)
);


register_file(
	.clk(clk),
	.rst(rst),
	.A1(RD_instr[19:15]),
	.A2(RD_instr[24:20]),
	.A3(RD_instr[11:7]),
	.WE3(RegWrite),
	.WD3(Result),
	.RD1(RD1_op),
	.RD2(RD2_op)
);


Sign_extend(
	.Inp(RD_Instr),
	.Imm_ext(Imm_Ext_op),
	.ImmSrc(ImmSrc[0])
);


MUX mux_register_to_ALU(
	.a(RD2_op),
	.b(Imm_Ext_Top),
	.s(ALUSrc),
	.c(SrcB)
);


ALU alu(
	.A(RD_Instr_op),
	.B(Imm_ext_op),
	.result(ALU_result),
	.ALU_control(ALU_control_op),
	.overflow(),
	.carry(),
	.zero(),
	.negative()
);


Control_unit_top control_unit(
	.RegWrite(RegWrite),
	.ImmSrc(ImmSrc),
	.AluSrc(ALUSrc),
	.MemWrite(MemWrite),
	.ResultSrc(ResultSrc),
	.ALUControl(ALU_control_top),
	.funct3(RD_instr[14:12]),
	.funct7(RD_instr[6:0]),
	.Op(RD_instr[6:0]),
	.Branch()
);


Data_Memory data_mem(
	.clk(clk),
	.rst(rst),
	.A(ALU_result),
	.WD(RD2_op),
	.WE(MemWrite),
	.RD(ReadData)
);


MUX mux_data_memory_to_register(
	.a(ALU_result),
	.b(ReadData),
	.s(ResultSrc),
	.c(Result)
);


endmodule
