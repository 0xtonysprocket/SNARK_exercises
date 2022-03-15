Compile Circuit:

1. circom sig_circuit.circom --r1cs --wasm --sym --c

Create Signature then Write Input:

2. node create_input.js

Generate Witness: (from inside sig_circuit_js)

3. node generate_witness.js sig_circuit.wasm input.json witness.wtns

Start Powers of Tau:

4. snarkjs powersoftau new bn128 14 pot14_0000.ptau -v

Contribute to PoT:

5. snarkjs powersoftau contribute pot14_0000.ptau pot14_0001.ptau --name="First contribution" -v

Start Phase 2:

6. snarkjs powersoftau prepare phase2 pot14_0001.ptau pot14_final.ptau -v

Setup Groth16

7. snarkjs groth16 setup sig_circuit.r1cs pot14_final.ptau sig_circuit_0000.zkey

Contribute to PoT:

8. snarkjs zkey contribute sig_circuit_0000.zkey sig_circuit_0001.zkey --name="1st Contributor Name" -v

Export Verification Key:

9. snarkjs zkey export verificationkey sig_circuit_0001.zkey verification_key.json

Generate Proof:

10. snarkjs groth16 prove sig_circuit_0001.zkey witness.wtns proof.json public.json

Verify Proof:

11. snarkjs groth16 verify verification_key.json public.json proof.json






