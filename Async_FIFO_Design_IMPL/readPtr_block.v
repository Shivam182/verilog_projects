module read_ptr_block #(parameter WDTH = 3)(
	input r_clk,
	input r_resetn,
	input r_enbl,
	
	input [WDTH:0] write_ptr_synced, // This would be in gray code so we compare the gray version of read next pointer
	output reg empty_flag,
	output reg [WDTH:0] bin_rd_ptr, gry_rd_ptr
);

reg [WDTH:0] bin_rd_ptr_nxt;
reg [WDTH:0] gry_rd_ptr_nxt;

wire r_empty;

assign r_empty = (write_ptr_synced == gry_rd_ptr_nxt);


always @(posedge r_clk) begin 

	if(!empty_flag && r_enbl) begin
	  
	   bin_rd_ptr_nxt = bin_rd_ptr +  1;
	end else begin 
	   bin_rd_ptr_nxt = bin_rd_ptr;
	end

	gry_rd_ptr_nxt = (bin_rd_ptr_nxt >> 1) ^ bin_rd_ptr_nxt;
end


always @(posedge r_clk or negedge r_resetn) begin 

	if(!r_resetn) begin 
	   
	   bin_rd_ptr <= 0;
	   gry_rd_ptr <= 0;

	end else begin 
	   
	   bin_rd_ptr <= bin_rd_ptr_nxt;
	   gry_rd_ptr <= gry_rd_ptr_nxt;

	end

end



always @(posedge r_clk or negedge r_resetn) begin 

	if(!r_resetn) begin 
	   
	   empty_flag <= 1;

	end else begin 
	   empty_flag = r_empty;
	
	end

end



endmodule
