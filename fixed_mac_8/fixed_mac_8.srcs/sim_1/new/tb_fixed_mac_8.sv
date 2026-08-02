`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 23:29:26
// Design Name: 
// Module Name: tb_fixed_mac_8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_fixed_mac_8;

    logic clk, rst, enable;
    logic signed [7:0] A, B;
    logic signed [15:0] Y;

    fixed_mac_8 dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .A(A),
        .B(B),
        .Y(Y)
    );

    always #5 clk = ~clk;

    task do_mac(input signed [7:0] a_in,
                input signed [7:0] b_in);
    begin
        enable = 0;
        A = a_in;
        B = b_in;
        #5;

        enable = 1;
        #10;

        enable = 0;
        #5;
    end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        A = 0; B = 0;

        #10 rst = 0;

        do_mac(8'sd10, 8'sd2);   // 20
        do_mac(8'sd10, 8'sd2);   // 40
        do_mac(-8'sd5, 8'sd2);   // 30

        #20 $finish;
    end

endmodule