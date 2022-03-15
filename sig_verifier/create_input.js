const filesystem = require('fs')
const buildEddsa = require("circomlibjs").buildEddsa;
const buildBabyjub = require("circomlibjs").buildBabyjub;

BigInt.prototype.toJSON = function () {
    return this.toString()
};

async function create_signature() {
    let eddsa = await buildEddsa();
    let baby_jub = await buildBabyjub();
    let F = baby_jub.F;

    let content = "578459302"

    const message = F.e(content);
    const priv_key = Buffer.from("0001020304050607080902010203040506070809060102030405060708090001", "hex");
    const pub_key = eddsa.prv2pub(priv_key);
    const signature = eddsa.signMiMC(priv_key, message);

    console.assert(eddsa.verifyMiMC(message, signature, pub_key))

    let circuit_input = {
        'enabled': 1,
        'Ax': F.toObject(pub_key[0]),
        'Ay': F.toObject(pub_key[1]),
        'R8x': F.toObject(signature.R8[0]),
        'R8y': F.toObject(signature.R8[1]),
        'S': signature.S,
        'M': F.toObject(F.e(content))
    }

    filesystem.writeFile('sig_circuit_js/input.json', JSON.stringify(circuit_input), (err) => {
        if (err) throw err;
    })
}


create_signature();