`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 02:01:57 PM
// Design Name: 
// Module Name: ALU
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



module ALU (
    input [3:0] A,
    input [3:0] B,
    input [3:0] Opcode,
    input reset,
    output reg [3:0] Result,
    output reg Overflow
);

reg [7:0] mult_result;


always @(*) begin
    if (reset) begin
        Result = 4'b0000;
        Overflow = 0;
    end else begin
        Overflow = 0;
        case (Opcode)
            4'b0000: begin
                Result = A + 1;
                Overflow = (A == 4'b1111);
            end
            4'b0001: begin
                Result = B + 1;
                Overflow = (B == 4'b1111);
            end
            4'b0010: begin
                Result = A - B;
                Overflow = (A < B);
            end
            4'b0011: begin
                Result = A + B;
                Overflow = (A + B > 4'b1111);
            end
            4'b0100: begin 
                mult_result = A * B;
                if (mult_result[7:4] != 0) begin
                    Overflow = 1; 
                    Result = 4'b0000; 
                end else begin
                    Result = mult_result[3:0]; 
                end
            end
            4'b0101: Result = A >> 1;
            4'b0110: begin
                Result = A << 1;
                Overflow = A[3];
            end
            4'b0111: Result = B >> 1;
            4'b1000: begin
                Result = B << 1;
                Overflow = B[3];
            end
            4'b1001: Result = A % B; 
            4'b1010: Result = A & B; 
            4'b1011: Result = A | B; 
            4'b1100: Result = A ^ B;
            4'b1101: Result = 4'bxxxx; 
            4'b1110: Result = 4'bxxxx; 
            4'b1111: Result = 4'bxxxx; 
            default: Result = 4'b0000;
        endcase
    end
end

endmodule



