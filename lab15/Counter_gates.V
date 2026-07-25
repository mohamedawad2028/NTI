module counter ( clock, reset, up, count);
input clock , reset , up ;
output wire [1:0] count
wire q0_next, q1_next;
wire xnor_out;

reg q0, q1;

not  Gate1(q0_next, q0);
xnor Gate2(xnor_out, q0, up);
xor  Gate3(q1_next, q1, xnor_out);
always @(posedge clock or posedge reset) begin
    if (reset) begin
        q0 <= 1'b0;
        q1 <= 1'b0;
    end
    else begin
        q0 <= q0_next;
        q1 <= q1_next;
    end
end

assign count = {q1, q0};

endmodule