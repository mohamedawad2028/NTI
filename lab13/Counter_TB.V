module ctr_fsm_tb();
reg clock,reset,up;
wire [1:0] count;
integer i=0;
 ctr_fsm DUT ( .clock(clock) , .reset(reset) , .up(up) , .count(count) );

initial begin
	clock<=0;
	forever
		#1 clock=~clock;
end

initial begin
	reset=1;
	up=1;
	@(negedge clock);
	reset=0;
	for(i=0 ; i<100 ; i=i+1)begin
		up=$random;
		@(negedge clock);
	end
	$stop;
end
endmodule