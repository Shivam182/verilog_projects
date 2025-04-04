module Sign_extend(
	input [31:0] Inp,
	output [31:0] Imm_ext,
	input ImmSrc
);

assign Imm_ext = (ImmSrc == 1'b1) ? ({{20{Inp[31]}},Inp[31:25],Inp[11:7]}):
                                        {{20{Inp[31]}},Inp[31:20]};

endmodule
