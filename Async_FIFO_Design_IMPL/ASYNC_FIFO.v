//`include "synchronizer.v"
//`include "fifo_RAM.v"
//`include "writePtr_block.v"
//`include "readPtr_block.v"



module ASYNC_FIFO #(parameter DEPTH = 8, DATA_WD = 8)(
	input r_clk, w_clk,
	input r_enbl, w_enbl,
	input r_resetn, w_resetn,

	output  full_flag, empty_flag,
	output  [DATA_WD-1:0] data_out,
	input [DATA_WD-1:0] data_in
);

parameter PTR_WD = $clog2(DEPTH);

wire [PTR_WD:0] gry_wptr_sync, gry_rptr_sync;
wire [PTR_WD:0] bin_wptr, bin_rptr;
wire [PTR_WD:0] gry_wptr, gry_rptr;

wire [PTR_WD-1:0] w_addr, r_addr;

flop_synchronizer #(PTR_WD) sync_write_ptr (r_clk, r_resetn, gry_wptr, gry_wptr_sync); 
flop_synchronizer #(PTR_WD) sync_read_ptr (w_clk, w_resetn, gry_rptr, gry_rptr_sync);  

write_Ptr_block #(PTR_WD) write_controller(w_resetn, w_clk, w_enbl, gry_rptr_sync, full_flag, bin_wptr, gry_wptr);
read_ptr_block #(PTR_WD) read_controller(r_clk, r_resetn, r_enbl, gry_wptr_sync, empty_flag, bin_rptr, gry_rptr);
fifo_RAM fifoRAM(r_clk, w_clk, r_enbl, w_enbl, full_flag, empty_flag, bin_rptr, bin_wptr, data_in, data_out);

endmodule