module part2(ClockIn, Reset, Speed, CounterValue);
	input ClockIn, Reset;
	input [1:0] Speed;
	output [3:0] CounterValue;
	wire Enable;
	wire [10:0] RateDivider;		
	CountRateDivider r1 (.Speed(Speed), .Out(RateDivider), .ClockIn(ClockIn), .Clear_b(Reset));

	assign Enable = (RateDivider == 11'b00000000000) ? 1'b1 : 1'b0;
	
	full_counter c1 (.q(CounterValue), .Clock(ClockIn), .Clear_b(~Reset), .Enable(Enable));
	
endmodule


module full_counter(q, Clock, Clear_b, Enable);
	input Clock, Clear_b, Enable;
	output reg[3:0] q;// declare q
	
	always@(posedge Clock)// triggered every time clock rises
		begin
			if(Clear_b  ==  1'b0)// when Clearb is 0
				q <= 4'b000;// q is set to 0
			else if(Enable)			// increment q only when Enable is 1
				q <= q + 1;// increment 
		end

endmodule 


module CountRateDivider(Speed, Out, ClockIn, Clear_b);
	input [1:0] Speed;
	input	ClockIn, Clear_b;
	output reg [10:0] Out;
	
	reg [10:0] d;
	
	always @(Speed)
	begin
	case (Speed)
		2'b00: d <= 11'b00000000000;
		2'b01: d <= 11'b00111110011;
		2'b10: d <= 11'b01111100111;
		2'b11: d <= 11'b11111001111;
		default: d <= 11'b00000000000;
	endcase
	end
	
	always@ (posedge ClockIn)
	begin
	
		if(Clear_b)
			Out <= 11'b00000000000;
		else if (Out == 11'b00000000000)				
			Out <= d;
		else  
			Out <= Out - 1;
		end
	
endmodule
