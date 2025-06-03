%% Main Algorithm Verification
clear
clc
close all
addpath('MATLAB')
%% Input Generator
L = 512;
Row = randi(8, L, 1) - 1;
Col = [Row(1); (randi(8, L-1, 1)-1)];
Vec = randi(8, L, 1) - 1;

% files
f1 = fopen("Row.dat", "w");
f2 = fopen("Col.dat", "w");
f3 = fopen("Vec.dat", "w");

for idx=1:L
    fprintf(f1, "%s\n", dec2hex(Row(idx)));
    fprintf(f2, "%s\n", dec2hex(Col(idx)));
    fprintf(f3, "%s\n", dec2hex(Vec(idx)));
end
%% MATLAB FUNCTION
c = Main_Multiplier_New(Col, Row, Vec, 24);
A = toeplitz(Col, Row);
b = Vec;
c_M = A*b;
%% RTL Simulation
RTL_c = importdata("Out.dat");
%% Comparison
d = RTL_c - c;
plot(d)

