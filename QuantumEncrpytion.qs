// Author: Senyao Hou
// Copyright: Copyright 2019, Insomnia Project
// License: MIT
// Email: senyao.hou@gmail.com
// Version: 0.0.1

namespace QuantumEncrpytion {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Bitwise;

    operation QuantumEncrpytion(message: Int) : (Int, Int) {

        using ((qubits_A, qubits_B) = (Qubit[8], Qubit[8])) {
            let size_qubits = Length(qubits_A);
            //Create entangled qubits in Bell State
            Message("Entangle 8 pairs of Qubits and distribute them to Alice and Bob...");
            Message("");

            for (i in 0..size_qubits - 1) {      
                CreateBellState(qubits_A[i], qubits_B[i]);
            }

            //Alice measures her set of Qubits
            Message("Alice measures her Qubits");
            let measurements_A = MeasureQubits(qubits_A);
            Message("");

            //Alice encrypts the message with the measurements of her Qubits
            let encryptedMessage = Xor(message, measurements_A);
            Message("Alice encrypted her message with her measurements of Qubits and send it to Bob.");
            Message("");

            //Bob measures his Qubits
            Message("Bob measures his Qubits");
            let measurements_B = MeasureQubits(qubits_B);
            Message("");

            //Reset all the Qubits back to |0>
            for (i in 0..size_qubits - 1) {
                ResetQubit(qubits_A[i]);    
                ResetQubit(qubits_B[i]);
            }

            //Returning Alice's encryted message and Bob's measurements
            return (encryptedMessage, measurements_B);  
        }
    }

    operation CreateBellState(qubit_A : Qubit, qubit_B : Qubit) : Unit {
        H(qubit_A);
        CNOT(qubit_A, qubit_B);
    }

    operation MeasureQubits(qubits : Qubit[]) : Int {
        mutable results = new Bool[0];   
        for (i in 0..Length(qubits) - 1) {      
            let result = M(qubits[i]);
            let resultBool = ResultAsBool(result); 
            let resultInt = ResultArrayAsInt([result]);
            Message($"Qubit {i} in state: |{resultInt}>");
            set results = results + [resultBool];
        }
        let resultsInt = BoolArrayAsInt(results);
        return resultsInt;
    }

    operation ResetQubit(qubit : Qubit) : Unit {
        let result = M(qubit);   

        if (result == Zero) {          
        } else {
            X(qubit);
        }
    }

}
