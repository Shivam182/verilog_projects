module gray_cell(
	input A, B, Cin, Sin,
	output So, Co
);

wire a;

assign a = ~(A&B);

FA fullAdder(.A(a), .B(Sin), .Cin(Cin), .Sum(So), .Cout(Co));

endmodule
