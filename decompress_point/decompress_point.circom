pragma circom 2.0.0;

include "../circomlib/circuits/compconstant.circom";
include "../circomlib/circuits/babyjub.circom";
include "../circomlib/circuits/bitify.circom";
include "../circomlib/circuits/pointbits.circom";

template decompress_point() {
    signal input x_bits[254];
    signal input y_sign;

    signal output x;
    signal output y;

    var i;
    var p = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

    component b2nY = Bits2Num(254);
    for (i=0; i<254; i++) {
        b2nY.in[i] <== in[i];
    }

    x <== b2nY.out;

    //constants from Edwards Curve a * x^2 + y^2 = 1 + d * x^2 * y^2
    var a = 168700;
    var d = 168696;

    var x2 = x*x;

    //calculate value that will be input to mod_sqrt
    var before_sqrt = (a*x2 - 1) / (d*x2 - 1);

    //mod_sqrt to find y
    var y_candidate_1 = sqrt(before_sqrt);
    var y_candidate_2 = p - y_candidate_1;

    if (y_candidate_1 / 2 == y_sign) {
        y <== y_candidate_1;
    } else {
        y <== y_candidate_2;
    }

    component babyCheck = BabyCheck();
    babyCheck.x <== x;
    babyCheck.y <== y;
}