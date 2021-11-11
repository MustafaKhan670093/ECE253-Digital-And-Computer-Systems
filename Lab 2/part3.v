
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
