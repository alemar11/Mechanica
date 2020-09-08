extension FixedWidthInteger {
  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// Example:
  ///
  ///     Int8(10).binaryString -> "00001010"
  ///     255.binaryString -> "11111111"
  ///     Int16(-1).binaryString -> "1111111111111111"
  ///     1.binaryString -> "0000000000000000000000000000000000000000000000000000000000000001" (Int 64 bit)
  ///     1.binaryString -> "00000000000000000000000000000001" (Int 32 bit)
  ///
  /// - Note: Negative integers are converted with the **two's complement operation**. For signed binary use `String(:radix:)`
  ///
  /// Example:
  ///
  ///     String(Int8(-127), radix: 2) -> -1111111
  ///     Int8(-127).binaryString -> 10000001
  ///
  var binaryString: String {
    var result: [String] = []

    for i in 0..<(Self.bitWidth / 8) {
      let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
      let byteString = String(byte, radix: 2)
      let padding = String(repeating: "0", count: 8 - byteString.count)
      result.append(padding + byteString)
    }

    // return "0b" + result.reversed().joined(separator: "_")
     return result.reversed().joined(separator: "")
  }
}
