module ctr_fsm( clock ,reset , up , count );
parameter zero =2'b00;
parameter one  =2'b01;
parameter two  =2'b10;
parameter three=2'b11;

input clock,reset,up;
output reg [1:0] count;
reg [1:0] cs,ns;

always @(posedge clock or posedge reset) begin
	if (reset) begin
		cs<=zero;
	end
	else begin
		cs<=ns;
	end
end

always @(*) begin
	case(cs)
		zero:
			if (up) begin
				ns=one;
			end
			else begin
				ns=three;
			end
		one:
			if (up) begin
				ns=two;
			end
			else begin
				ns=zero;
			end
		two:
			if (up) begin
				ns=three;
			end
			else begin
				ns=one;
			end
		three:
			if (up) begin
				ns=zero;
			end
			else begin
				ns=two;
			end
		default:
			ns=zero;
	endcase
end

always @(*)begin
	if (cs==zero) begin
		count=2'b00;
	end
	else if (cs==one ) begin
		count=2'b01;
	end
	else if (cs==two) begin
		count=2'b10;
	end
	else if (cs==three) begin
		count=2'b11;
	end	

	else begin
		count=2'b00;
	end
end

endmodule