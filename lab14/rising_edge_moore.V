module rising_edge_moore (clk,rst,level,tick);
parameter ZERO=2'b00;
parameter EDGE=2'b01;
parameter ONE=2'b10;
input clk,level;
output reg tick;
reg cs,ns;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		cs<=ZERO;
	end
	else begin
		cs<=ns;
	end
end

always@(*) begin
	case(cs)
		ZERO:
			if (level) begin
				ns=EDGE;
			end
			else begin
				ns=cs;
			end
		EDGE:
			if (level) begin
				ns=ONE;
			end
			else begin
				ns=ZERO;
			end
		ONE:
			if (level) begin
				ns=cs;
			end
			else begin
				ns=ZERO;
			end	
		default:
			ns=ZERO;
endcase						
end
always @(*) begin
	if (cs==ZERO) begin
		tick=0;
	end
	else if (cs==EDGE) begin
		tick=1;
	end
	else if (cs==ONE) begin
		tick=0;
	end
	else begin
		tick=0;
	end
end


endmodule