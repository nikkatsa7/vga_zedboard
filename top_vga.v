`timescale 1ns / 1ps
module top_vga(clk, reset, red, green, blue, vsync,hsync);

input clk,reset;
output vsync,hsync;
output reg [3:0] red,green,blue;    

reg CLK_50;
wire Xdisplay,Ydisplay;
wire [9:0] haddr;
wire [8:0] vaddr;

horizontal HSYNC(CLK_50,reset,haddr,hsync,Xdisplay);
vertical VSYNC(CLK_50,reset,vaddr,vsync,Ydisplay);

/***********CLK DIVIDER**************************/
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        CLK_50 <= 0;
    end
    else begin
        CLK_50 <= ~CLK_50;
    end
end

always@(posedge CLK_50)
begin
    if(Xdisplay && Ydisplay)
    begin
        red <= 4'b0010;
        green <= 4'b0111;
        blue <= 4'b0001;
    end else begin
        red <= 0;
        green <= 0;
        blue <= 0; 
    end   
 end
 
endmodule
