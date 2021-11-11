module part1 (Clock, Enable, Clear_b, CounterValue);
  input Enable;
  input Clock;
  input Clear_b;
  output [7:0] CounterValue;

  wire input1, input2, input3, input4, input5, input6, input7;
  wire CounterValue0, CounterValue1, CounterValue2, CounterValue3, CounterValue4, CounterValue5, CounterValue6, CounterValue7;

  tflipflop t0(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(Enable),
    .Q(CounterValue0)
    );
  and(input1, Enable, CounterValue0); // AND Gate connecting t0 and t1
  assign CounterValue[0] = CounterValue0;

  tflipflop t1(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input1),
    .Q(CounterValue1)
    );
  and a(input2, input1, CounterValue1);
  assign CounterValue[1] = CounterValue1;

  tflipflop t2(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input2),
    .Q(CounterValue2)
    );
  and(input3, input2, CounterValue2);
  assign CounterValue[2] = CounterValue2;

  tflipflop t3(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input3),
    .Q(CounterValue3)
    );
  and(input4, input3, CounterValue3);
  assign CounterValue[3] = CounterValue3;

  tflipflop t4(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input4),
    .Q(CounterValue4)
    );
  and(input5, input4, CounterValue4);
  assign CounterValue[4] = CounterValue4;

  tflipflop t5(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input5),
    .Q(CounterValue5)
    );
  and(input6, input5, CounterValue5);
  assign CounterValue[5] = CounterValue5;

  tflipflop t6(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input6),
    .Q(CounterValue6)
    );
  and(input7, input6, CounterValue6);
  assign CounterValue[6] = CounterValue6;

  tflipflop t7(
    .Clk(Clock),
    .Clear_b(Clear_b),
    .T(input7),
    .Q(CounterValue7)
    );
  assign CounterValue[7] = CounterValue7;


endmodule // counter

module tflipflop (Clk, Clear_b, T, Q);
  input Clk;
  input Clear_b;
  input T;
  output Q;
  reg Q;

  always @(posedge Clk, negedge Clear_b)
    begin
      if (Clear_b == 1'b0)
        Q <= 1'b0;
      else
        Q <= Q ^ T;
    end

endmodule // tflipflop




// Seven Segment Decoder, takes binary input and CounterValueputs it in hex
//module seven_seg_decoder(SW,HEX0);
  //input [3:0] SW;
  //output [6:0] HEX0;

 // assign HEX0[0] = (~SW[3]&~SW[2]&~SW[1]&SW[0]) | (~SW[3]&SW[2]&~SW[1]&~SW[0]) | (SW[3]&SW[2]&~SW[1]&SW[0]) | (SW[3]&~SW[2]&SW[1]&SW[0]);
 // assign HEX0[1] = (SW[3]&SW[1]&SW[0]) | (SW[3]&SW[2]&~SW[0]) | (SW[2]&SW[1]&~SW[0]) | (~SW[3]&SW[2]&~SW[1]&SW[0]);
 // assign HEX0[2] = (SW[3]&SW[2]&~SW[0]) | (SW[3]&SW[2]&SW[1]) | (~SW[3]&~SW[2]&SW[1]&~SW[0]);
 // assign HEX0[3] = (SW[2]&SW[1]&SW[0]) | (~SW[2]&~SW[1]&SW[0]) | (~SW[3]&SW[2]&~SW[1]&~SW[0]) | (SW[3]&~SW[2]&SW[1]&~SW[0]);
 // assign HEX0[4] = (~SW[3]&SW[0]) | (~SW[3]&SW[2]&~SW[1]) | (~SW[2]&~SW[1]&SW[0]);
 // assign HEX0[5] = (~SW[3]&~SW[2]&SW[1]) | (~SW[3]&~SW[2]&SW[0]) | (~SW[3]&SW[1]&SW[0]) | (SW[3]&SW[2]&~SW[1]&SW[0]);
 // assign HEX0[6] = (~SW[3]&~SW[2]&~SW[1]) | (SW[3]&SW[2]&~SW[1]&~SW[0]) | (~SW[3]&SW[2]&SW[1]&SW[0]);

//endmodule //seven_seg_decoder