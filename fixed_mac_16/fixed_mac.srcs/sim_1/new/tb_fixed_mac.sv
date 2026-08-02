`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 00:49:29
// Design Name: 
// Module Name: tb_fixed_mac
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


module tb_fixed_mac;

    logic clk;
    logic rst;
    logic enable;

    logic signed [15:0] A;
    logic signed [15:0] B;
    logic signed [31:0] Y;

    // DUT
    fixed_mac dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Clock
    always #5 clk = ~clk;

    // MAC operation aligned with clock
    task do_mac(input signed [15:0] a_in,
                input signed [15:0] b_in);
    begin
        @(posedge clk);
        A = a_in;
        B = b_in;
        enable = 1;

        @(posedge clk);
        enable = 0;
    end
    endtask

    initial begin
        // Init
        clk = 0;
        rst = 1;
        enable = 0;
        A = 0;
        B = 0;

        // 🔴 START TOGGLE CAPTURE
        $set_toggle_region("tb_fixed_mac.dut");
        $toggle_start();

        @(posedge clk);
        rst = 0;

        // Test 1
        do_mac(16'sd3, 16'sd2);   // 6
        do_mac(16'sd3, 16'sd2);   // 12
        do_mac(-16'sd4, 16'sd2);  // 4

        // Reset
        @(posedge clk);
        rst = 1;
        @(posedge clk);
        rst = 0;

        // Multiple MAC
        repeat (5) do_mac(16'sd10, 16'sd2); // 100

        // 🔴 STOP + WRITE SAIF
        $toggle_stop();
        $toggle_report("fixed_mac.saif", 1e-9, "tb_fixed_mac.dut");

        #20;
        $finish;
    end

    // VCD (optional debug)
    initial begin
        $dumpfile("fixed_mac.vcd");
        $dumpvars(1, dut);
    end

endmodule
