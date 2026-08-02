`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 23:15:37
// Design Name: 
// Module Name: fixed_mac_4
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


module fixed_mac_4 (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic signed [3:0] A,
    input  logic signed [3:0] B,
    output logic signed [7:0] Y
);

    logic signed [7:0] mult;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            Y <= 0;
        end else if (enable) begin
            mult = A * B;
            Y <= Y + mult;
        end
    end

endmodule
