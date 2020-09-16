extension BinaryFloatingPoint {
  /// **Mechanica**
  ///
  /// Creates a string representing the given value in the binary base.
  ///
  /// Example:
  ///
  ///     Float(-5.625).binaryString -> "11000000101101000000000000000000
  ///
  public var binaryString: String {
    let floatingPointSign = (sign == FloatingPointSign.minus) ? "1" : "0"
    let exponentBitCount = Self.exponentBitCount
    let mantissaBitCount = Self.significandBitCount

    var exponent = String(Int(self.exponentBitPattern), radix: 2)
    var mantissa = String(Int(self.significandBitPattern), radix: 2)

    if exponentBitCount > exponent.count {
      exponent = String(repeating: "0", count: (exponentBitCount - exponent.count)) + exponent
    }
    if mantissaBitCount > mantissa.count {
      mantissa = String(repeating: "0", count: (mantissaBitCount - mantissa.count)) + mantissa
    }

    return "\(floatingPointSign)\(exponent)\(mantissa)"
  }
}
