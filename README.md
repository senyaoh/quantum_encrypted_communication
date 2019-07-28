# A Simulation of Quantum Encrypted Communication with Q# using One-Time Pad

## Requirement
1. Install the latest version of the [.NET Core SDK](https://dotnet.microsoft.com)
2. Install `IQSharp` by running `dotnet tool install -g Microsoft.Quantum.IQSharp`
3. Install kernel spec `dotnet iqsharp install`
4. Install python package `pip3 install qsharp`
5. Start the program by running `python3 quantum_encrypted_communication.py`

## Description
This is a simulation of quantum encrypted communication with Q# using one-time pad encryption. Alice takes a message and break it into characters, for each character it is turned into 8-bit binary form using ascii encoding. Then we entangle 8 pairs of Qubits and turn them into bell states. Then we distribute each of the entagled Qubit to Alice And Bob. When Alice measures all 8 of her Qubits, she collapses them into |0> or |1>,
because her Qubits and entangled with Bob's Qubits, Bob's Qubits will collapse into the same states. Then Alice uses the collapsed states as the encryption key. She take the 8-bit binary form of the character and perform xor with the 8-bits collapsed Qubits. Then she sends the encrypted binary to Bob, Bob with in turn uses his measurements of his Qubits, which should be identical to Alice's measurements, to perfrom xor with the encrypted binary received from Alice, the result should be the uncrypted 8-bit binary of the character.

### Qubits Entanglement

### One-Time Pad