module fifo_RAM #(parameter DEPTH = 8, PTR_WD = 3, DATA_WD = 8)(
	input r_clk,
	input w_clk,
	input r_enbl,
	input w_enbl,
	input full_flag, empty_flag,
	input [PTR_WD:0] bin_rd_ptr, bin_wr_ptr,
	input [DATA_WD-1:0] data_in,
	output reg [DATA_WD-1:0] data_out
);

reg [DATA_WD-1:0] mem [0:DEPTH-1];

always @(posedge w_clk) begin 

if(w_enbl && !full_flag) begin 

   mem[bin_wr_ptr[PTR_WD-1:0]] <= data_in;

end

end

always @(posedge r_clk) begin
	
	if(r_enbl && !empty_flag) begin 
	  data_out <= mem[bin_rd_ptr[PTR_WD -1:0]];
	end

end



endmodule
