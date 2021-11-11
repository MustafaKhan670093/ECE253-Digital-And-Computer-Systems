module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);
	input Clock;
	input Resetn;
	input Go;
	input [3:0] Divisor;
	input [3:0] Dividend;
	output [3:0] Quotient;
	output [3:0] Remainder;
	
	//wires to connect
	wire loada;
	wire loadq;
	wire loadr;
	wire A_Sel;
	wire variable_that_gets_carried;
	wire DATALOAD;
	wire alu_output;
	wire tempA;

	control con0 (.Clock(Clock), .Resetn(Resetn), .Go(Go), .tempA(tempA), .A_Sel(A_Sel), .variable_that_gets_carried(variable_that_gets_carried), .DATALOAD(DATALOAD), .loada(loada), .loadq(loadq), .loadr(loadr),
		.alu_output(alu_output));
	
	datapath dpath0 (.Clock(Clock), .Resetn(Resetn), .DATALOAD(DATALOAD), .A_Sel(A_Sel), .variable_that_gets_carried(variable_that_gets_carried), .loada(loada), .loadq(loadq), .loadr(loadr), .alu_output(alu_output), .tempA(tempA), .Divisor({1'b0, Divisor}), .Dividend(Dividend), .Quotient(Quotient), .Remainder(Remainder));
	
endmodule

//datapath to calculate division
module datapath(Clock, Resetn, DATALOAD, A_Sel, variable_that_gets_carried, loada, loadq, loadr, alu_output, tempA, Divisor, Dividend, Quotient, Remainder);
	input Clock;
	input Resetn;
	input DATALOAD;
	input A_Sel;
	input variable_that_gets_carried;
	input loada;
	input loadq;
	input loadr;
	input alu_output;
	input [3:0] Dividend;
	input [4:0] Divisor;
	output reg [3:0] Quotient;
	output reg [3:0] Remainder;
	output tempA;

	reg [4:0] Areg;
	reg [3:0] Qreg;
	reg [4:0] ALUOUT;
	
	wire [4:0] SHIFT_REG_A = {Areg[3:0], Qreg[3]};
	wire [3:0] SHIFT_REG_Q = Qreg << 1;
	
	assign tempA = ALUOUT[4];
	
	always @(posedge Clock) 
		begin
		if (!Resetn) begin
			Quotient <= 0;
			Remainder <= 0;
			Areg <= 0;
			Qreg <= 0;
		end
		else if (DATALOAD) 
		begin
			if (loada)	
				Areg <= 0;
			if (loadq)
				Qreg <= Dividend;
		end
		else 
		begin
			if (loada) 
			begin
				Areg <= A_Sel ? ALUOUT : SHIFT_REG_A;
			end
			if (loadq)
				if (A_Sel) 
				begin
					Qreg[0] <= variable_that_gets_carried;
				end
				else 
				begin
					Qreg <= SHIFT_REG_Q;
				end
			if (loadr) 
			begin
				Quotient <= Qreg;
				Remainder <= Areg[3:0]; 
			end
		end
	end
		
	always @(*) begin
		case (alu_output)
			0: ALUOUT <= Areg + Divisor;
			1: ALUOUT <= Areg - Divisor;
		endcase
	end
endmodule

//control path to save states (FSM)
module control(Clock, Resetn, Go, tempA, A_Sel, variable_that_gets_carried, DATALOAD, loada, loadq, loadr, alu_output);
	input Clock;
	input Resetn;
	input Go;
	input tempA;
	output reg A_Sel;
	output reg loadq;
	output reg variable_that_gets_carried;
	output reg DATALOAD;
	output reg alu_output;
	output reg loada;
	output reg loadr;
	
	reg [2:0] LOOP_COUNT;
	reg [2:0] CURRENTSTATE;
	reg [2:0] NEXTSTATE;
	
	localparam load_s = 3'b000, wait_load = 3'b001, CYC0 = 3'b010, CYC1 = 3'b011, CYC2 = 3'b100, CYC3 = 3'b101, CYC4 = 3'b110, SAVESTATE = 3'b111;
	
	always @(*) 
	begin: state_table
		case (CURRENTSTATE)
			load_s: NEXTSTATE = Go ? wait_load : load_s;
			wait_load: NEXTSTATE = Go ? wait_load : CYC0;
			CYC0: NEXTSTATE = CYC1;
			CYC1: NEXTSTATE = tempA ? CYC3 : CYC2;
			CYC2: NEXTSTATE = LOOP_COUNT == 0 ? SAVESTATE : CYC0;
			CYC3: NEXTSTATE = CYC4;
			CYC4: NEXTSTATE = LOOP_COUNT == 0 ? SAVESTATE : CYC0;
			SAVESTATE: NEXTSTATE = load_s;
			default: NEXTSTATE = load_s;
		endcase
	end
	
	always @(*) 
	begin: signals_from_enable
		A_Sel = 0;
		variable_that_gets_carried = 0;
		DATALOAD = 0;
		loada = 0;
		loadq = 0;
		loadr = 0;
		alu_output = 0;
	
		case (CURRENTSTATE)
			load_s: begin
				DATALOAD = 1;
				loada = 1;
				loadq = 1;
			end
			CYC0: begin
				A_Sel = 0;
				loada = 1;
				loadq = 1;
			end
			CYC1: begin
				A_Sel = 1;
				loada = 1;
				alu_output = 1; 
			end
			CYC2: begin
				A_Sel = 1;
				loada = 0; 
				loadq = 1;
				variable_that_gets_carried = 1;
			end
			CYC3: begin
				A_Sel = 1;
				loada = 1;
				loadq = 0; 
				alu_output = 0; 
			end
			CYC4: begin
				A_Sel = 1;
				loada = 0;
				loadq = 1;
				variable_that_gets_carried = 0;
			end
			SAVESTATE: begin
				loadr = 1;
			end
		endcase
	end
	
//Clock and reset
	
	always @(posedge Clock) 
		begin: state_FFs
		if (!Resetn) begin
			CURRENTSTATE <= load_s;
		end
		else
			CURRENTSTATE <= NEXTSTATE;
			if (NEXTSTATE == CYC0) begin
				LOOP_COUNT = LOOP_COUNT - 1;
			end
			else if (NEXTSTATE == load_s) begin
				LOOP_COUNT = 4;
			end
	end
endmodule


