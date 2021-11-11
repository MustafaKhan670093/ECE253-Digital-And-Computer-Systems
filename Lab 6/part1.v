module part1(Clock,Resetn, w, z, CurState);
	input Clock;
	input Resetn;
	input w;
	output z;
	output [3:0] CurState;
	
	reg [3:0] currentstate, nextstate;
	localparam A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110;
	
	always@(*)
	begin: state_table
		case (currentstate)
			A: begin
					if (!w) nextstate = A;
					else nextstate = B;
				end
			B: begin
					if (!w) nextstate = A;
					else nextstate = C;
				end
			C: begin
					if (!w) nextstate = E;
					else nextstate = D;
				end
			D: begin
					if (!w) nextstate = E;
					else nextstate = F;
				end
			E: begin
					if (!w) nextstate = A;
					else nextstate = G;
				end
			F: begin
					if (!w) nextstate = E;
					else nextstate = F;
				end
			G: begin
					if (!w) nextstate = A;
					else nextstate = C;
				end
			default: nextstate = A;
		endcase
	end
	
	
	always @(posedge Clock)
	begin: state_FFs
		if (Resetn == 1'b0)
			currentstate <= A;
		else
			currentstate <= nextstate;
	end
	
	assign z = ((currentstate == F) | (currentstate == G));
	assign CurState = currentstate;
endmodule