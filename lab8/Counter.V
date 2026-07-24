module counter ( clk , rst , cnt_in , enab , load , cnt_out);
input clk,rst, enab,load;
input [4:0] cnt_in;
output [4:0] cnt_out;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		cnt_out<=0;
	end
	else begin
		if (load) begin
			cnt_out<=cnt_in;
		end
		else begin
			if (enab) begin
				cnt_out<=cnt_out+1
			end
		end

	end
end

endmodule 