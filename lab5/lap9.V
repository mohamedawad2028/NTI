module memory (clk , wr , rd , addr , data_in , data_out );
parameter Awidth =5;
parameter Dwidth =8;
parameter mem_width=2**Awidth;
input[Awidth-1:0] addr;
input clk,wr,rd;
input [Dwidth-1:0] data_in;
output reg [Dwidth-1:0] data_out;
reg [Dwidth-1:0] mem [mem_width-1:0];

always @(posedge clk ) begin
	if (wr) begin
		mem[addr] <= data_in;
	end
end
assign data_out=(rd==1)? mem[addr] :0;



endmodule 