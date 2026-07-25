module parity_gen (clk,reset,serial_in,parity_out);
input clk,reset,serial_in;
output  parity_out;
reg [7:0] shift_reg;

task calc_parity;
    input [7:0] data_window;
    output parity;
    begin
        parity = ^data_window;
    end
endtask

always @(posedge clk) begin
    if (reset) begin
        shift_reg  <= 8'b0;
        parity_out <= 1'b0;
    end
    else begin
        shift_reg <= {shift_reg[6:0], serial_in};
        calc_parity({shift_reg[6:0], serial_in}, parity_out);
    end
end
endmodule