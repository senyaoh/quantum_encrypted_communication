#!/usr/bin/env python3

'''
This is a simulation of Quantum Encrypted Communication with Q# using One-Time Pad
'''

__author__ = 'Senyao Hou'
__copyright__ = 'Copyright 2019, Insomnia Project'
__credits__ = ['Senyao Hou']
__license__ = 'MIT'
__version__ = '0.0.1'
__maintainer__ = 'Senyao Hou'
__email__ = 'senyao.hou@gmail.com'
__status__ = 'Development'

import qsharp
from QuantumEncrpytion import QuantumEncrpytion

def simulateCommunication(alice_message: str):
    bob_received_message = ""
    counter = 1

    for character in alice_message:
        print(f"Sending character {counter}:")
        alice_send_character = ord(character)
        send_character_bin = character_bin(alice_send_character)
        print(f"Alice's message': {character} -> {send_character_bin}")
        print("")

        (bob_received_encrypted_character, bob_measurements) = QuantumEncrpytion.simulate(message=alice_send_character)
        print(f"Bob received message: {character_bin(bob_received_encrypted_character)}")
        print(f"Bob's meassurements:  {character_bin(bob_measurements)}")

        bob_decrypted_character = decrypt_message(bob_received_encrypted_character, bob_measurements)
        print(f"Bob's decryption:     {character_bin(bob_decrypted_character)} -> {chr(bob_decrypted_character)}")
        print("")

        bob_received_message += chr(bob_decrypted_character)

        counter += 1

    print("Bob's decrypted received message:")
    print(bob_received_message)

def character_bin(character: int) -> str:
    return '{:08b}'.format(character)

def decrypt_message(message: int, key: int) -> str:
    return message ^ key

if __name__ == '__main__':
    message = input("Enter Alice's message: ")
    simulateCommunication(message)