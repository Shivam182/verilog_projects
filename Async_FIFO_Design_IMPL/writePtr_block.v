module write_Ptr_block #(parameter WDTH = 3)(
	input w_resetn,
	input w_clk,
	input w_enbl,
	
	input [WDTH:0] read_ptr_synced,
	output reg full_flag,
	output reg [WDTH:0] bin_wr_ptr, gry_wr_ptr
	
);

reg [WDTH:0] bin_wr_nxt_ptr;
reg [WDTH:0] gry_wr_nxt_ptr;

wire w_full;

always @(posedge w_clk) begin

	if(!full_flag && w_enbl) begin

	  bin_wr_nxt_ptr = bin_wr_ptr + 1;
          
	end else begin

	  bin_wr_nxt_ptr = bin_wr_ptr;
	end

	gry_wr_nxt_ptr = (bin_wr_nxt_ptr >> 1)^bin_wr_nxt_ptr;
end



always @(posedge w_clk or negedge w_resetn) begin 

	if(!w_resetn) begin 

          bin_wr_ptr <= 0;
	  gry_wr_ptr <= 0;

	end else begin 

	  bin_wr_ptr <= bin_wr_nxt_ptr;
	  gry_wr_ptr <= gry_wr_nxt_ptr;	
 
	end

end




always @(posedge w_clk or negedge w_resetn) begin 

	if(!w_resetn) begin 
	   full_flag <= 0;	
	end else begin 
	   full_flag <= w_full;
	end

end

// Fifo Full condition 
assign w_full = (gry_wr_nxt_ptr == {~read_ptr_synced[WDTH:WDTH-1], read_ptr_synced[WDTH-2:0]});


endmodule
