/**
Working Description:

1. The CPUs, DMAs work as AHB masters generating various control signals.
2. Now they don't directly generate AHB signals but translators are used.
3. These translator interfaces convert signals from CPUs/DMAs to AHB specific.
4. Further the signal is passed onto the AMBA architecture for further processing.

*/

module Ahb_master(
	input Hclk, // The 'H' prefix denotes high performance.
	input Hresetn, // 'n' denotes active low signal, it halts all transactions and components perform initialization
	input Hreadyout, // This signal is initiated from slave towards master.
	
	input [1:0] Hresp, // Output from slave towards master, indicating outcome of a transaction.
	input [31:0] Hrdata, // transfers data from slave towards master for read operations
	
	output reg Hreadyin, Hwrite, // ready signal from slave to master & write enable signal from master to slave
	output reg [31:0] Hwdata, Haddr, 
	output reg [1:0] Htrans // specifies the type of transaction, from master to slave
);

reg [2:0] Hburst; // from master to slave, signifies the type of burst transfer.
reg [1:0] Hsize; // indicates the size of each burst transfer values encoded by binary code. 



task single_write();
begin

// Initialize the signals for write operation
@(posedge Hclk) #2;
begin 
    Hwrite=1;
    Htrans=2'b10;
    Hsize=3'b000;
    Hburst=3'b000;
    Hreadyin=1;
    Haddr=32'h8000_0001;
end


@(posedge Hclk) #2;
begin 
    Htrans=2'b00;
    Hwdata=8'hA3;
end


end
endtask


task single_read();
begin

@(posedge Hclk) #2; begin
    Hwrite=0;
    Htrans=2'b10;
    Hsize=3'b000;
    Hburst=3'b000;
    Hreadyin=1; // This signal is given as input to master signifying readiness of the slave.
    Haddr=32'h8000_00A2;
end


@(posedge Hclk) #2; begin
    Htrans=2'b00;
end

end
endtask




endmodule