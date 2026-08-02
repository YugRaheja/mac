`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 20:15:37
// Design Name: 
// Module Name: tb_bit_selector
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


module tb_bit_selector;

    logic signed [15:0] in;
    logic [1:0] mode;

    // Outputs
    logic signed [15:0] sel_out;
    logic signed [15:0] ext_out;

    // Instantiate bit_selector
    bit_selector u1 (
        .in(in),
        .mode(mode),
        .out(sel_out)
    );

    // Instantiate sign_extender
    sign_extender u2 (
        .in(sel_out),
        .mode(mode),
        .out(ext_out)
    );

    initial begin
        $display("Starting Combined Test...");

        // -------------------------------
        // Test 1: Negative number (-3)
        // -------------------------------
        in = -16'sd3;

        mode = 2'b00; // INT4
        #10;
        $display("INT4:  in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        mode = 2'b01; // INT8
        #10;
        $display("INT8:  in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        mode = 2'b10; // INT16
        #10;
        $display("INT16: in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        // -------------------------------
        // Test 2: Positive number (25)
        // -------------------------------
        in = 16'sd25;

        mode = 2'b00; // INT4
        #10;
        $display("INT4:  in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        mode = 2'b01; // INT8
        #10;
        $display("INT8:  in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        mode = 2'b10; // INT16
        #10;
        $display("INT16: in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        // -------------------------------
        // Test 3: Edge case (-8 for INT4)
        // -------------------------------
        in = -16'sd8;

        mode = 2'b00; // INT4
        #10;
        $display("INT4 edge: in=%0d | sel_out=%b | ext_out=%0d",
                  in, sel_out, ext_out);

        $finish;
    end

endmodule
