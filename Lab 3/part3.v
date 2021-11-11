module part3(A, B, Function, ALUout);
	input [3:0] A, B;
	input [2:0] Function;
	output reg [7:0] ALUout;

	wire [3:0] w1, w2;

	part2 p2 (.a(A), .b(B), .c_in(1'b0), .s(w1[3:0]), .c_out(w2));

	always@(*)
	begin
		case (Function)
			3'b000: ALUout = {3'b000, w1};
			3'b001: ALUout = A+B;
			3'b010: ALUout = {{4{B[3]}}, B};
			3'b011: ALUout = {7'b000, |{A,B}};
			3'b100: ALUout = {7'b000, &{A,B}};
			3'b101: ALUout = {A,B};
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule

 
module part1(MuxSelect, Input, Out);

	input [2:0] MuxSelect;

	input [6:0] Input;

	output [6:0] Out;

reg Out; 
always@(*)
begin
	case(MuxSelect[2:0])
		3'b000: Out = Input[0];
		3'b001: Out = Input[1];
		3'b010: Out = Input[2];
		3'b011: Out = Input[3];
		3'b100: Out = Input[4];
		3'b101: Out = Input[5];
		3'b110: Out = Input[6];
		
		default: Out = 7'bx;
	endcase
end

endmodule


module fulladder(a,b,c_in,s,c_out);
	input a,b,c_in;
	output s,c_out;
	 
	assign s = (a ^ b) ^ c_in;
	assign c_out = (b &~( a ^ b)) | (c_in & ( a ^ b ));
endmodule


module part2(a, b, c_in, s, c_out);
	input [3:0] a;
	input [3:0] b;
	input  c_in;
	output [3:0] s;
	output [3:0] c_out;

	fulladder u1(a[0],b[0],c_in,s[0], c_out[0]);
	fulladder u2(a[1],b[1],c_out[0],s[1], c_out[1]);
	fulladder u3(a[2],b[2],c_out[1],s[2], c_out[2]);
	fulladder u4(a[3],b[3],c_out[2],s[3], c_out[3]);
endmodule


//HEX

module h0(c, disp0);
    input [3:0] c;
    output disp0;
    assign disp0 = ~c[3]&~c[2]&~c[1]&c[0] | ~c[3]&c[2]&~c[1]&~c[0] | c[3]&~c[2]&c[1]&c[0] | c[3]&c[2]&~c[1]&c[0];
endmodule


module h1(c, disp1);
    input [3:0] c;
    output disp1;
    assign disp1 = ~c[3]&c[2]&~c[1]&c[0] | c[2]&c[1]&~c[0] | c[3]&c[1]&c[0] | c[3]&c[2]&~c[0];
endmodule

module h2(c, disp2);
    input [3:0] c;
    output disp2;
    assign disp2 = ~c[3]&~c[2]&c[1]&~c[0] | c[3]&c[2]&~c[0] | c[3]&c[2]&c[1];
endmodule


module h3(c, disp3);
    input [3:0] c;
    output disp3;
    assign disp3 = ~c[3]&~c[2]&~c[1]&c[0] | ~c[3]&c[2]&~c[1]&~c[0] | c[2]&c[1]&c[0] | c[3]&~c[2]&c[1]&~c[0];
endmodule


module h4(c, disp4);
    input [3:0] c;
    output disp4;
     assign disp4 = ~c[3]&c[0] | ~c[2]&~c[1]&c[0] | ~c[3]&c[2]&~c[1];
endmodule


module h5(c, disp5);
    input [3:0] c;
    output disp5;
    assign disp5 = ~c[3]&~c[2]&c[0] | ~c[3]&~c[2]&c[1] | ~c[3]&c[1]&c[0] | c[3]&c[2]&~c[1]&c[0];
endmodule


module h6(c, disp6);
    input [3:0] c;
    output disp6;
    assign disp6 = ~c[3]&~c[2]&~c[1] | ~c[3]&c[2]&c[1]&c[0] | c[3]&c[2]&~c[1]&~c[0];
endmodule

module hex_decoder(c, display);
    input [3:0] c;
    output [6:0] display;
   
    h0 u0(.c(c), .disp0(display[0]));
    h1 u1(.c(c), .disp1(display[1]));
    h2 u2(.c(c), .disp2(display[2]));
    h3 u3(.c(c), .disp3(display[3]));
    h4 u4(.c(c), .disp4(display[4]));
    h5 u5(.c(c), .disp5(display[5]));
    h6 u6(.c(c), .disp6(display[6]));
endmodule


