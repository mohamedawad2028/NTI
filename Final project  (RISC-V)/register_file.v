module register ( clk , rd1_addr , rd2_addr , wr_addr , wr_data , wr_en , rd1_data , rd2_data); //register file uses an approch "read after write" && this is a collection of registers 
parameter address=5;
parameter width =32;
parameter depth=2**address;
input clk , wr_en ;                                      // er_en = reg_write /////////////
input [address-1:0] rd1_addr,rd2_addr,wr_addr;                //  rd1_addr = rs1_addr & rd2_addr = rs2_addr & wr_addr = rd_addr /////////
input [width-1:0] wr_data ;                                    // wr_data = rd_data;
output reg [width-1:0] rd1_data , rd2_data ;                       //  rd1_data = rs1_data &  rd2_data =rs2_data
reg [width-1:0] mem [depth-1:0];

always @(posedge clk ) begin
	if (wr_en) begin
			mem[wr_addr] <= wr_data;
	end
end
always @(*) begin
	if (rd1_addr==0) begin
		rd1_data=0;
	end
	else begin
		rd1_data = mem[rd1_addr];
	end

	if (rd2_addr==0) begin
		rd2_data=0;
	end
	else begin
		rd2_data = mem[rd2_addr];
	end
end
endmodule 