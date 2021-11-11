module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    input clock, reset, ParallelLoadn, RotateRight, ASRight;
    input [7:0] Data_IN;
    output [7:0] Q;
    
    wire w1;
    
    mux2to1 M0(.x(Q[0]), .y(Q[7]), .s(ASRight), .m(w1));
    reginstance Q7(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[7]), .Q(Q[7]), .right(Q[6]), .left(w1));
    reginstance Q6(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[6]), .Q(Q[6]), .right(Q[5]), .left(Q[7]));
    reginstance Q5(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[5]), .Q(Q[5]), .right(Q[4]), .left(Q[6]));
    reginstance Q4(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[4]), .Q(Q[4]), .right(Q[3]), .left(Q[5]));
    reginstance Q3(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[3]), .Q(Q[3]), .right(Q[2]), .left(Q[4]));
    reginstance Q2(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[2]), .Q(Q[2]), .right(Q[1]), .left(Q[3]));
    reginstance Q1(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[1]), .Q(Q[1]), .right(Q[0]), .left(Q[2]));
    reginstance Q0(.loadLeft(RotateRight), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .D(Data_IN[0]), .Q(Q[0]), .right(Q[7]), .left(Q[1]));
endmodule

module reginstance(right, left, loadLeft, D, loadn, clock, reset, Q);
    input right, left, loadLeft, D, loadn, clock, reset;
    output Q;
    
    wire w1, w2;
    
    mux2to1 M0(.x(right), .y(left), .s(loadLeft), .m(w1));
    mux2to1 M1(.x(D), .y(w1), .s(loadn), .m(w2));
    
    flipflop F0(.d(w2), .q(Q), .clock(clock), .reset(reset));
endmodule

module mux2to1(y,x,s,m);
    input y,x,s;
    output m;
    assign m = (~s & x)|(s & y);
endmodule

module flipflop(d, q, clock, reset);
    input d, clock, reset;
    output reg q;
    
    always @(posedge clock)
    begin
        if (reset == 1'b1)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
