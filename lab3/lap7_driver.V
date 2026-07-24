module driver(data_in,data_en,data_out);
parameter N=8;
input [N-1:0] data_in;
input data_en;
output reg [N-1:0] data_out;
always @(*) begin
	if (data_en) begin
		data_out=data_in;
	end
	else begin
		data_out= 'hz;
	end
end
endmodule