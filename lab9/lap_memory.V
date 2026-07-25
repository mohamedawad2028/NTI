module parity_gen(clk, reset,serial_in, parity_out);
input clk,reset,serial_in;
output parity_out;
reg [7:0] shift_reg;

function calc_parity;
    input [7:0] data_window;
    begin
        calc_parity = ^data_window;
    end
endfunction

always @(posedge clk)
begin
    if (reset) begin
        shift_reg <= 8'b0000_0000;
    end
    else begin
        shift_reg <= {shift_reg[6:0], serial_in};
    end
end

assign parity_out = calc_parity(shift_reg);

endmodule