%% Multiplier Verification
clear
clc
close all
addpath("MATLAB")
%% Input Generator
N = 512;
Real_N = 509;
SIZE_TMVP = 32;
Row = zeros(N,1);
Col = zeros(N,1);
Vec = zeros(N,1);
Row(1:Real_N) = randi(8, Real_N, 1) - 1;
Col(1:Real_N) = [Row(1); (randi(8, Real_N-1, 1)-1)];
Vec(1:Real_N) = randi(8, Real_N, 1) - 1;

% files
f1 = fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Memory/ROW.mem", "w");
f2 = fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Memory/COL.mem", "w");
f3 = fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Memory/VEC.mem", "w");
for idx=1:N
    fprintf(f1, "%s\n", dec2hex(Row(idx)));
    fprintf(f2, "%s\n", dec2hex(Col(idx)));
    fprintf(f3, "%s\n", dec2hex(Vec(idx)));
end
fclose(f1);
fclose(f2);
fclose(f3);
%% MATLAB FUNCTION
c = Main_Multiplier_New(Col, Row, Vec, SIZE_TMVP);
A = toeplitz(Col, Row);
b = Vec;
c_M = c(1:Real_N);
%% RTL Simulation
RTL_c = importdata("Top.dat");
%% Comparison
d = RTL_c - c_M;
plot(d)

