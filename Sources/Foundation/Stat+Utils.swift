// https://github.com/nsomar/FileUtils
// https://github.com/RubyNative/SwiftRuby
// https://www.gnu.org/software/libc/manual/html_node/Testing-File-Type.html

#if canImport(Glibc)
import Glibc
#elseif canImport(Darwin)
import Darwin.C
#endif

/// **Mechanica**
///
/// The structure of the data returned by the functions `fstat()`, `lstat()`, and `stat()`.
typealias Stat = stat

extension Stat {
  /// **Mechanica**
  ///
  /// Returns `true` if the file is a symbolik link.
  internal var isLink: Bool {
    return S_ISLNK(Int(st_mode))
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the file is a directory.
  internal var isDirectory: Bool {
    return S_ISDIR(Int(st_mode))
  }

  /// **Mechanica**
  ///
  /// Returns `true` if the file is a regular file.
  internal var isFile: Bool {
    return S_ISREG(Int(st_mode))
  }
}

// MARK: - Symbols in <sys/stat.h> that are not defined in Foundation

// swiftlint:disable identifier_name
// swiftlint:disable private_over_fileprivate

/// **Mechanica**
///
/// This is a bit mask used to extract the file type code from a mode value.
fileprivate let S_IFMT: Int = 0o170000

/// **Mechanica**
///
/// This is the file type constant of a FIFO or pipe.
fileprivate let S_IFIFO: Int = 0o010000

/// **Mechanica**
///
/// This is the file type constant of a character-oriented device file.
fileprivate let S_IFCHR: Int = 0o020000

/// **Mechanica**
///
/// This is the file type constant of a directory file.
fileprivate let S_IFDIR: Int = 0o040000

/// **Mechanica**
///
/// This is the file type constant of a block-oriented device file.
fileprivate let S_IFBLK: Int = 0o060000

/// **Mechanica**
///
/// This is the file type constant of a regular file.
fileprivate let S_IFREG: Int = 0o100000

/// **Mechanica**
///
/// This is the file type constant of a symbolic link.
fileprivate let S_IFLNK: Int = 0o120000

/// **Mechanica**
///
/// This is the file type constant of a socket.
fileprivate let S_IFSOCK: Int = 0o140000

// swiftlint:enable private_over_fileprivate

/// **Mechanica**
///
/// Returns `true` if the file is a block special file (a device like a disk).
internal func S_ISBLK(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFBLK)
}

/// **Mechanica**
///
/// Returns `true` if the file is a character special file (a device like a terminal).
internal func S_ISCHR(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFCHR)
}

/// **Mechanica**
///
/// Returns `true` if the file is a directory.
internal func S_ISDIR(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFDIR)
}

/// **Mechanica**
///
/// Returns `true` if the file is a FIFO special file, or a pipe.
internal func S_ISFIFO(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFIFO)
}

/// **Mechanica**
///
/// Returns `true` if the file is a regular file.
internal func S_ISREG(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFREG)
}

/// **Mechanica**
///
/// Returns `true` if the file is a symbolic link.
internal func S_ISLNK(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFLNK)
}

/// **Mechanica**
///
/// Returns `true` if the file is a socket.
internal func S_ISSOCK(_ m: Int) -> Bool {
  return (((m) & S_IFMT) == S_IFSOCK)
}

// swiftlint:enable private_over_fileprivate
// swiftlint:enable identifier_name
