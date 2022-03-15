pragma circom 2.0.0;

include "../circomlib/circuits/eddsamimc.circom";

template mimc_sig_verifier() {
    signal input enabled;
    
    //coordinates of public key
    signal input Ax;
    signal input Ay;

    //message
    signal input M;

    //signature where S is int and (R8x, R8y) is coordinate
    signal input S;
    signal input R8x;
    signal input R8y;

    component mimc = EdDSAMiMCVerifier();
    mimc.enabled <== enabled;
    mimc.Ax <== Ax;
    mimc.Ay <== Ay;
    mimc.S <== S;
    mimc.R8x <== R8x;
    mimc.R8y <== R8y;
    mimc.M <== M;
}

component main{public [enabled, Ax, Ay, M]} = mimc_sig_verifier();