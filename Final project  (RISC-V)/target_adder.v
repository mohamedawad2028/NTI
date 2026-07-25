module adder (
input  wire [31:0] in1,
input  wire [31:0] in2,
output wire [31:0] sum
);

assign sum = in1 + in2;

endmodule