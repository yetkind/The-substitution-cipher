import strutils, tables, sequtils

# Function to create encryption and decryption table
proc createCipherMaps(substitutionKey: string): (Table[char, char], Table[char, char]) =
  let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  var encryptMap = initTable[char, char]()
  var decryptMap = initTable[char, char]()

  for i in 0..<alphabet.len:
    encryptMap[alphabet[i]] = substitutionKey[i]
    decryptMap[substitutionKey[i]] = alphabet[i]
  
  return (encryptMap, decryptMap)

# Function to encrypt plaintext
proc encrypt(plaintext: string, encryptMap: Table[char, char]): string =
  var ciphertext = newStringOfCap(plaintext.len)
  for ch in plaintext.toUpperAscii():
    if ch in encryptMap:
      ciphertext.add(encryptMap[ch])
    else:
      ciphertext.add(ch)  # Non-alphabet characters are added
  return ciphertext

# Function to decrypt ciphertext
proc decrypt(ciphertext: string, decryptMap: Table[char, char]): string =
  var plaintext = newStringOfCap(ciphertext.len)
  for ch in ciphertext.toUpperAscii():
    if ch in decryptMap:
      plaintext.add(decryptMap[ch])
    else:
      plaintext.add(ch)  # Non-alphabet characters are added
  return plaintext

# get user input and perform encryption and decryption
proc main() =
  echo "Enter the substitution key (26 unique uppercase letters):"
  let substitutionKey = readLine(stdin).strip()
  
  if substitutionKey.len != 26 or not substitutionKey.all(proc(c: char): bool = c in 'A'..'Z'):
    echo "Invalid substitution key. It must be 26 unique uppercase letters."
    return

  let (encryptMap, decryptMap) = createCipherMaps(substitutionKey)

  echo "Enter the plaintext to encrypt:"
  let plaintext = readLine(stdin).strip()
  let encryptedText = encrypt(plaintext, encryptMap)
  echo "Encrypted text: ", encryptedText

  echo "Enter the ciphertext to decrypt:"
  let ciphertext = readLine(stdin).strip()
  let decryptedText = decrypt(ciphertext, decryptMap)
  echo "Decrypted text: ", decryptedText

main()
