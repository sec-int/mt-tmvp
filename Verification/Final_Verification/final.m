%% Multiplier Verification
clear
clc
close all
addpath("MATLAB")
%% Input Generator
N = 512;
Real_N = 509;
SIZE_TMVP = 32;
DATA_WIDTH = 8;
max_n = 2^DATA_WIDTH;
f = randi(2^(DATA_WIDTH-1), Real_N, 1) - 1;
g = randi(2^(DATA_WIDTH-1), Real_N, 1) - 1;
Row = zeros(N,1);
Col = zeros(N,1);
Vec = zeros(N,1);
Row(1:Real_N) = [f(1); flip(f(2:end))];
Col(1:Real_N) = f;
Vec(1:Real_N) = g;

% files
f1 = fopen("f.mem", "w");
f2 = fopen("g.mem", "w");
for idx=1:Real_N
    fprintf(f1, "%s\n", dec2hex(f(idx)));
    fprintf(f2, "%s\n", dec2hex(g(idx)));
end
fclose(f1);
fclose(f2);
%% MATLAB FUNCTION
c = Main_Multiplier_New(Col, Row, Vec, SIZE_TMVP, max_n);
A = toeplitz(Col, Row);
b = Vec;
c_2 = mod(A*b, max_n);
c_M = mod(c(1:Real_N), max_n);
%% RTL Simulation
RTL_c = importdata("final.dat");
%% Comparison
d = RTL_c - c_M;
figure
subplot(2,1,1)
plot(c_M)
hold on
plot(RTL_c)
legend("MATLAB", "RTL",'interpreter','latex')
xlabel("n",'interpreter','latex')
subtitle("Output of the MATLAB function \& RTL module",'interpreter','latex')
subplot(2,1,2)
plot(d)
subtitle("Difference between the Outputs",'interpreter','latex')
xlabel("n",'interpreter','latex')


