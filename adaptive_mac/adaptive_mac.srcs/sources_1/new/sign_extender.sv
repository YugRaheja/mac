`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 20:19:56
// Design Name: 
// Module Name: sign_extender
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


module sign_extender(
    input  signed [15:0] in,
    input  [1:0] mode,
    output logic signed [15:0] out
);

always_comb begin
    case (mode)
        2'b00: out = {{12{in[3]}}, in[3:0]};   // INT4
        2'b01: out = {{8{in[7]}}, in[7:0]};    // INT8
        2'b10: out = in;                      // INT16
        default: out = in;
    endcase
end

endmodule
