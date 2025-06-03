function c_M = TMVP2_multiplier(Col, Row, Vec, L)
    A = toeplitz(Col, Row);
    b = Vec;
    A0 = A(1:L/2, 1:L/2);
    A1 = A(1+L/2:L, 1:L/2);
    A2 = A(1:L/2, 1+L/2:L);
    b0 = b(1:L/2);
    b1 = b(1+L/2: L);
    Mat0_1 = A0;
    vec0_1 = (b0+b1);
    c0_1 = Mat0_1 * vec0_1;
    Mat0_2 = (A2-A0);
    vec0_2 = b1;
    c0_2 = Mat0_2 * vec0_2;
    c0 = c0_1 + c0_2;
    Mat1_1 = A0;
    vec1_1 = (b0+b1);
    c1_1 = Mat1_1 * vec1_1;
    Mat1_2 = (A1-A0);
    vec1_2 = b0;
    c1_2 = Mat1_2 * vec1_2;
    c1 = c1_1 + c1_2;
    c_M = [c0;c1];
end

