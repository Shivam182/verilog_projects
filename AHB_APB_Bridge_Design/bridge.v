module Bridge_Top(
input Hclk,Hresetn,Hwrite,Hreadyin,
input [31:0] Hwdata,Haddr,Prdata,
input[1:0] Htrans,
output Penable,Pwrite,Hreadyout,
output [1:0] Hresp,
output [2:0] Pselx,
output [31:0] Paddr,Pwdata,
output [31:0] Hrdata
);


wire valid;
wire [31:0] Haddr1,Haddr2,Hwdata1,Hwdata2;
wire Hwritereg;
wire [2:0] tempselx;




Ahb_slave AHBSlave (Hclk,Hresetn,Hwrite,Hreadyin,Htrans,Haddr,Hwdata,Prdata,valid,Haddr1,Haddr2,Hwdata1,Hwdata2,Hrdata,Hwritereg,tempselx,Hresp);

Ahb2Apb_bridge APBControl ( Hclk,Hresetn,valid,Haddr1,Haddr2,Hwdata1,Hwdata2,Prdata,Hwrite,Haddr,Hwdata,Hwritereg,tempselx,Pwrite,Penable,Pselx,Paddr,Pwdata,Hreadyout);


endmodule
