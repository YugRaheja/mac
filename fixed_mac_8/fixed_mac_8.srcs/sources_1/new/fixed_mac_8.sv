`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 23:28:55
// Design Name: 
// Module Name: fixed_mac_8
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


module fixed_mac_8 (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic signed [7:0] A,
    input  logic signed [7:0] B,
    output logic signed [15:0] Y
);

    logic signed [15:0] mult;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            Y <= 0;
        end else if (enable) begin
            mult = A * B;
            Y <= Y + mult;
        end
    end

endmodule
