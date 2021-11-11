module part2(Clock, Reset_b, Data, Function, ALUout);

	input Clock, Reset_b;
	input [3:0] Data;

	input [2:0] Function;
	//input [3:0] B;

	reg [7:0] q;
	wire [3:0] B;
	output reg [7:0] ALUout;

	wire [3:0] w1, w2;
	//wire w1_0, w1_1, w1_2, w1_3, w2_0, w2_1, w2_2, w2_3;

	assign B = ALUout[3:0];


	lab3part2 p2(.a(Data), .b(B), .c_in(1'b0), .s(w1[3:0]), .c_out(w2));

	always@(*)// declare always block
		begin
			case(Function[2:0])
			  4'b0000: q = {3'b000, w2[3], w1};
			  4'b0001: q = Data + B;
			  4'b0010: q = {{4{B[3]}}, B};
			  4'b0011: q = {{7{1'b0}}, |{Data, B}};
			  4'b0100: q = {{7{1'b0}}, &{Data, B}};
			  4'b0101: q =  B<<Data;
			  4'b0110: q = Data*B;
			  4'b0111: q = ALUout;
			  default: q = 8'b00000000;
			 endcase
		end
 
	 always@(posedge Clock)
		begin
			  if(Reset_b == 1'b0)
					ALUout<= 8'b00000000;
			  else
					ALUout<= q;
		 end
	endmodule



module fulladder(a,b,c_in,s,c_out);
	input a,b,c_in;
	output s,c_out;
	 
	assign s = (a ^ b) ^ c_in;
	assign c_out = (b &~( a ^ b)) | (c_in & ( a ^ b ));

endmodule


module lab3part2(a, b, c_in, s, c_out);
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