module multiplexer(in0,in1,sel,mux_out);
parameter N=5;
input [N-1:0] in0,in1;
input sel;
output reg [N-1:0] mux_out;
always @(*) begin
	if (sel) begin
		mux_out=in1;
	end
	else begin
		mux_out=in0;
	end
end

endmodule