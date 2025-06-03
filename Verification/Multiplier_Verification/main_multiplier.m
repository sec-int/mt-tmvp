%% Multiplier Verification
clear
clc
close all
%% Input Generator
N = 16;
DATA_WIDTH = 8;
Row = randi(2^(DATA_WIDTH-1), N, 1) - 1;
Col = [Row(1); (randi(2^(DATA_WIDTH-1), N-1, 1)-1)];
Vec = randi(2^(DATA_WIDTH-1), N, 1) - 1;

% files
f1 = fopen("Row.dat", "w");
f2 = fopen("Col.dat", "w");
f3 = fopen("Vec.dat", "w");

for idx=1:N
    fprintf(f1, "%s\n", dec2hex(Row(idx)));
    fprintf(f2, "%s\n", dec2hex(Col(idx)));
    fprintf(f3, "%s\n", dec2hex(Vec(idx)));
end
%% MATLAB FUNCTION
A = toeplitz(Col, Row);
b = Vec;
c = mod(A*b, 2^DATA_WIDTH);
%% RTL Simulation
RTL_c = importdata("Out.dat");
%% Comparison
d = RTL_c - c;
plot(d)

