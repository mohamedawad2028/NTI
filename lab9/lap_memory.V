module memory(addr,wr,rd,clk,data_in,data_out);
parameter AWIDTH=5;
parameter DWIDTH=8;
parameter mem_width=2**AWIDTH;
input [AWIDTH-1:0] addr;
input wr,rd,clk;
input [DWIDTH-1:0]data_in;
output reg [DWIDTH-1:0]data_out;
reg [DWIDTH-1:0] memory [mem_width-1:0];

always @(posedge clk ) begin
	if (wr)begin
		memory[addr]=data_in;
	end
	else if (rd) begin
		data_out=memory[addr];
	end
end

endmodule