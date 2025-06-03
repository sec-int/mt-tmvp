function c_M = TMVP2_multiplier(Col, Row, Vec, L, max_n)
    A = toeplitz(Col, Row);
    b = Vec;
    A0 = A(1:L/2, 1:L/2);
    A1 = A(1+L/2:L, 1:L/2);
    A2 = A(1:L/2, 1+L/2:L);
    b0 = b(1:L/2);
    b1 = b(1+L/2: L);
    Mat0_1 = A0;
    vec0_1 = mod((b0+b1), max_n);
    c0_1 = mod(Mat0_1 * vec0_1, max_n);
    Mat0_2 = mod((A2-A0), max_n);
    vec0_2 = b1;
    c0_2 = mod(Mat0_2 * vec0_2, max_n);
    c0 = mod(c0_1 + c0_2, max_n);
    c1_1 = mod(Mat0_1 * vec0_1, max_n);
    Mat1_2 = mod((A1-A0), max_n);
    vec1_2 = b0;
    c1_2 = mod(Mat1_2 * vec1_2, max_n);
    c1 = mod(c1_1 + c1_2,max_n);
    c_M = [c0;c1];
end

