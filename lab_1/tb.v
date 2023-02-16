`include "bound_flash.v"
`default_nettype none

module bound_flash_tb;
reg clk = 0;
reg flick = 1;
reg lamp[15:0];

bound_flash
(
    .clk (clk),
    .flick (flick),
    .lamp (lamp)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_main.vcd");
    $dumpvars(0, tb_main);
end

initial begin
    #1 lamp <= 16'b0000000000000000;
    #1 rst_n<=1'bx;clk<=1'bx;
    #(CLK_PERIOD*3) rst_n<=1;
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;
    repeat(5) @(posedge clk);
    rst_n<=1;
    @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule