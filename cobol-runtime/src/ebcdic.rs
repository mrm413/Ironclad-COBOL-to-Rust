// EBCDIC CP037 (US/Canada) encoding support for mainframe COBOL transpilation.
//
// IBM mainframes use EBCDIC (Extended Binary Coded Decimal Interchange Code)
// instead of ASCII. Key differences:
//   - Space = 0x40 (not 0x20)
//   - 'A' = 0xC1 (not 0x41)
//   - Sort order: lowercase < uppercase < digits (opposite of ASCII)
//   - Sign overpunch in zone bits for zoned decimal

/// EBCDIC CP037 → ASCII translation table (256 bytes).
/// Index = EBCDIC byte, Value = ASCII byte.
pub const E2A: [u8; 256] = [
    // 0x00-0x0F: Control characters
    0x00, 0x01, 0x02, 0x03, 0x9C, 0x09, 0x86, 0x7F, // 00-07
    0x97, 0x8D, 0x8E, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, // 08-0F
    // 0x10-0x1F
    0x10, 0x11, 0x12, 0x13, 0x9D, 0x85, 0x08, 0x87, // 10-17
    0x18, 0x19, 0x92, 0x8F, 0x1C, 0x1D, 0x1E, 0x1F, // 18-1F
    // 0x20-0x2F
    0x80, 0x81, 0x82, 0x83, 0x84, 0x0A, 0x17, 0x1B, // 20-27
    0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x05, 0x06, 0x07, // 28-2F
    // 0x30-0x3F
    0x90, 0x91, 0x16, 0x93, 0x94, 0x95, 0x96, 0x04, // 30-37
    0x98, 0x99, 0x9A, 0x9B, 0x14, 0x15, 0x9E, 0x1A, // 38-3F
    // 0x40-0x4F: Space + special chars
    0x20, 0xA0, 0xE2, 0xE4, 0xE0, 0xE1, 0xE3, 0xE5, // 40-47  (0x40 = space)
    0xE7, 0xF1, 0xA2, 0x2E, 0x3C, 0x28, 0x2B, 0x7C, // 48-4F  (. < ( + |)
    // 0x50-0x5F
    0x26, 0xE9, 0xEA, 0xEB, 0xE8, 0xED, 0xEE, 0xEF, // 50-57  (&)
    0xEC, 0xDF, 0x21, 0x24, 0x2A, 0x29, 0x3B, 0xAC, // 58-5F  (! $ * ) ;)
    // 0x60-0x6F
    0x2D, 0x2F, 0xC2, 0xC4, 0xC0, 0xC1, 0xC3, 0xC5, // 60-67  (- /)
    0xC7, 0xD1, 0xA6, 0x2C, 0x25, 0x5F, 0x3E, 0x3F, // 68-6F  (, % _ > ?)
    // 0x70-0x7F
    0xF8, 0xC9, 0xCA, 0xCB, 0xC8, 0xCD, 0xCE, 0xCF, // 70-77
    0xCC, 0x60, 0x3A, 0x23, 0x40, 0x27, 0x3D, 0x22, // 78-7F  (` : # @ ' = ")
    // 0x80-0x8F: Lowercase a-i
    0xD8, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, // 80-87  (a-g)
    0x68, 0x69, 0xAB, 0xBB, 0xF0, 0xFD, 0xFE, 0xB1, // 88-8F  (h, i)
    // 0x90-0x9F: Lowercase j-r
    0xB0, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, // 90-97  (j-p)
    0x71, 0x72, 0xAA, 0xBA, 0xE6, 0xB8, 0xC6, 0xA4, // 98-9F  (q, r)
    // 0xA0-0xAF: Lowercase s-z
    0xB5, 0x7E, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, // A0-A7  (~, s-x)
    0x79, 0x7A, 0xA1, 0xBF, 0xD0, 0xDD, 0xDE, 0xAE, // A8-AF  (y, z)
    // 0xB0-0xBF
    0x5E, 0xA3, 0xA5, 0xB7, 0xA9, 0xA7, 0xB6, 0xBC, // B0-B7  (^)
    0xBD, 0xBE, 0x5B, 0x5D, 0xAF, 0xA8, 0xB4, 0xD7, // B8-BF  ([ ])
    // 0xC0-0xCF: Uppercase A-I
    0x7B, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, // C0-C7  ({, A-G)
    0x48, 0x49, 0xAD, 0xF4, 0xF6, 0xF2, 0xF3, 0xF5, // C8-CF  (H, I)
    // 0xD0-0xDF: Uppercase J-R
    0x7D, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, // D0-D7  (}, J-P)
    0x51, 0x52, 0xB9, 0xFB, 0xFC, 0xF9, 0xFA, 0xFF, // D8-DF  (Q, R)
    // 0xE0-0xEF: Uppercase S-Z
    0x5C, 0xF7, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, // E0-E7  (\, S-X)
    0x59, 0x5A, 0xB2, 0xD4, 0xD6, 0xD2, 0xD3, 0xD5, // E8-EF  (Y, Z)
    // 0xF0-0xFF: Digits 0-9
    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, // F0-F7  (0-7)
    0x38, 0x39, 0xB3, 0xDB, 0xDC, 0xD9, 0xDA, 0x9F, // F8-FF  (8, 9)
];

/// ASCII → EBCDIC CP037 translation table (256 bytes).
/// Index = ASCII byte, Value = EBCDIC byte.
pub const A2E: [u8; 256] = [
    0x00, 0x01, 0x02, 0x03, 0x37, 0x2D, 0x2E, 0x2F, // 00-07
    0x16, 0x05, 0x25, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, // 08-0F
    0x10, 0x11, 0x12, 0x13, 0x3C, 0x3D, 0x32, 0x26, // 10-17
    0x18, 0x19, 0x3F, 0x27, 0x1C, 0x1D, 0x1E, 0x1F, // 18-1F
    0x40, 0x5A, 0x7F, 0x7B, 0x5B, 0x6C, 0x50, 0x7D, // 20-27  (space=0x40, !=5A, "=7F, #=7B, $=5B, %=6C, &=50, '=7D)
    0x4D, 0x5D, 0x5C, 0x4E, 0x6B, 0x60, 0x4B, 0x61, // 28-2F  ((=4D, )=5D, *=5C, +=4E, ,=6B, -=60, .=4B, /=61)
    0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, // 30-37  (0-7)
    0xF8, 0xF9, 0x7A, 0x5E, 0x4C, 0x7E, 0x6E, 0x6F, // 38-3F  (8, 9, :=7A, ;=5E, <=4C, ==7E, >=6E, ?=6F)
    0x7C, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, // 40-47  (@=7C, A-G)
    0xC8, 0xC9, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, // 48-4F  (H, I, J-O)
    0xD7, 0xD8, 0xD9, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, // 50-57  (P-R, S-W)
    0xE7, 0xE8, 0xE9, 0xBA, 0xE0, 0xBB, 0xB0, 0x6D, // 58-5F  (X-Z, [=BA, \=E0, ]=BB, ^=B0, _=6D)
    0x79, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, // 60-67  (`=79, a-g)
    0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, // 68-6F  (h, i, j-o)
    0x97, 0x98, 0x99, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, // 70-77  (p-r, s-w)
    0xA7, 0xA8, 0xA9, 0xC0, 0x4F, 0xD0, 0xA1, 0x07, // 78-7F  (x-z, {=C0, |=4F, }=D0, ~=A1, DEL=07)
    0x20, 0x21, 0x22, 0x23, 0x24, 0x15, 0x06, 0x17, // 80-87
    0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x09, 0x0A, 0x1B, // 88-8F
    0x30, 0x31, 0x1A, 0x33, 0x34, 0x35, 0x36, 0x08, // 90-97
    0x38, 0x39, 0x3A, 0x3B, 0x04, 0x14, 0x3E, 0xFF, // 98-9F
    0x41, 0xAA, 0x4A, 0xB1, 0x9F, 0xB2, 0x6A, 0xB5, // A0-A7
    0xBD, 0xB4, 0x9A, 0x8A, 0x5F, 0xCA, 0xAF, 0xBC, // A8-AF
    0x90, 0x8F, 0xEA, 0xFA, 0xBE, 0xA0, 0xB6, 0xB3, // B0-B7
    0x9D, 0xDA, 0x9B, 0x8B, 0xB7, 0xB8, 0xB9, 0xAB, // B8-BF
    0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9E, 0x68, // C0-C7
    0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77, // C8-CF
    0xAC, 0x69, 0xED, 0xEE, 0xEB, 0xEF, 0xEC, 0xBF, // D0-D7
    0x80, 0xFD, 0xFE, 0xFB, 0xFC, 0xAD, 0xAE, 0x59, // D8-DF
    0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9C, 0x48, // E0-E7
    0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57, // E8-EF
    0x8C, 0x49, 0xCD, 0xCE, 0xCB, 0xCF, 0xCC, 0xE1, // F0-F7
    0x70, 0xDD, 0xDE, 0xDB, 0xDC, 0x8D, 0x8E, 0xDF, // F8-FF
];

/// EBCDIC collating sequence weight table.
/// Maps EBCDIC byte values to sort-order weights for correct mainframe collation.
/// EBCDIC order: space < special < lowercase < uppercase < digits
/// (opposite of ASCII where digits < uppercase < lowercase)
pub const EBCDIC_WEIGHT: [u8; 256] = {
    let mut w = [0u8; 256];
    let mut i = 0u8;
    loop {
        w[i as usize] = i;
        if i == 255 { break; }
        i += 1;
    }
    w
};

/// Convert a single byte from EBCDIC CP037 to ASCII.
#[inline]
pub fn ebcdic_to_ascii(b: u8) -> u8 {
    E2A[b as usize]
}

/// Convert a single byte from ASCII to EBCDIC CP037.
#[inline]
pub fn ascii_to_ebcdic(b: u8) -> u8 {
    A2E[b as usize]
}

/// Convert a byte slice from EBCDIC CP037 to ASCII in-place.
pub fn ebcdic_to_ascii_buf(buf: &mut [u8]) {
    for b in buf.iter_mut() {
        *b = E2A[*b as usize];
    }
}

/// Convert a byte slice from ASCII to EBCDIC CP037 in-place.
pub fn ascii_to_ebcdic_buf(buf: &mut [u8]) {
    for b in buf.iter_mut() {
        *b = A2E[*b as usize];
    }
}

/// Convert EBCDIC CP037 bytes to a String.
pub fn ebcdic_to_string(data: &[u8]) -> String {
    let ascii: Vec<u8> = data.iter().map(|&b| E2A[b as usize]).collect();
    String::from_utf8_lossy(&ascii).into_owned()
}

/// Convert an ASCII/UTF-8 string to EBCDIC CP037 bytes.
pub fn string_to_ebcdic(s: &str) -> Vec<u8> {
    s.bytes().map(|b| A2E[b as usize]).collect()
}

/// Compare two byte slices using EBCDIC collating sequence.
/// This gives mainframe-correct sort order where:
///   lowercase < uppercase < digits (opposite of ASCII).
///
/// Both slices are treated as raw EBCDIC bytes — no conversion needed.
/// Shorter slices are logically padded with EBCDIC space (0x40).
pub fn ebcdic_compare(a: &[u8], b: &[u8]) -> std::cmp::Ordering {
    let len = a.len().max(b.len());
    for i in 0..len {
        let ba = if i < a.len() { a[i] } else { 0x40 }; // EBCDIC space
        let bb = if i < b.len() { b[i] } else { 0x40 };
        match ba.cmp(&bb) {
            std::cmp::Ordering::Equal => continue,
            other => return other,
        }
    }
    std::cmp::Ordering::Equal
}

/// Compare two ASCII strings using EBCDIC collating sequence.
/// Converts to EBCDIC first, then compares byte-by-byte.
pub fn ascii_compare_ebcdic_order(a: &str, b: &str) -> std::cmp::Ordering {
    let ea = string_to_ebcdic(a);
    let eb = string_to_ebcdic(b);
    ebcdic_compare(&ea, &eb)
}

/// Encoding mode for the transpiled program.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum EncodingMode {
    /// ASCII/UTF-8 — strings stored as ASCII, comparisons use ASCII order.
    /// Use for programs already converted to ASCII or running on open systems.
    #[default]
    Ascii,
    /// EBCDIC CP037 — strings stored as ASCII internally but comparisons
    /// use EBCDIC collating sequence. Use for mainframe-faithful behavior.
    EbcdicCollation,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_roundtrip_printable_ascii() {
        // Every printable ASCII char should roundtrip through A2E → E2A
        for b in 0x20u8..=0x7E {
            let ebcdic = A2E[b as usize];
            let back = E2A[ebcdic as usize];
            assert_eq!(back, b, "Roundtrip failed for ASCII 0x{:02X} ('{}') -> EBCDIC 0x{:02X} -> 0x{:02X}",
                b, b as char, ebcdic, back);
        }
    }

    #[test]
    fn test_known_mappings() {
        // Space
        assert_eq!(A2E[0x20], 0x40, "ASCII space should map to EBCDIC 0x40");
        assert_eq!(E2A[0x40], 0x20, "EBCDIC 0x40 should map to ASCII space");

        // 'A' = 0xC1 in EBCDIC
        assert_eq!(A2E[b'A' as usize], 0xC1);
        assert_eq!(E2A[0xC1], b'A');

        // 'a' = 0x81 in EBCDIC
        assert_eq!(A2E[b'a' as usize], 0x81);
        assert_eq!(E2A[0x81], b'a');

        // '0' = 0xF0 in EBCDIC
        assert_eq!(A2E[b'0' as usize], 0xF0);
        assert_eq!(E2A[0xF0], b'0');

        // '9' = 0xF9 in EBCDIC
        assert_eq!(A2E[b'9' as usize], 0xF9);
        assert_eq!(E2A[0xF9], b'9');
    }

    #[test]
    fn test_ebcdic_collation_order() {
        // EBCDIC: lowercase (0x81-0xA9) < uppercase (0xC1-0xE9) < digits (0xF0-0xF9)
        // This is the OPPOSITE of ASCII where digits < uppercase < lowercase

        // 'a' (0x81) < 'A' (0xC1) in EBCDIC
        assert_eq!(
            ascii_compare_ebcdic_order("a", "A"),
            std::cmp::Ordering::Less,
            "In EBCDIC, lowercase 'a' should sort BEFORE uppercase 'A'"
        );

        // 'A' (0xC1) < '0' (0xF0) in EBCDIC
        assert_eq!(
            ascii_compare_ebcdic_order("A", "0"),
            std::cmp::Ordering::Less,
            "In EBCDIC, uppercase 'A' should sort BEFORE digit '0'"
        );

        // 'z' (0xA9) < 'A' (0xC1) in EBCDIC
        assert_eq!(
            ascii_compare_ebcdic_order("z", "A"),
            std::cmp::Ordering::Less,
            "In EBCDIC, lowercase 'z' should sort BEFORE uppercase 'A'"
        );

        // '0' (0xF0) > 'Z' (0xE9) in EBCDIC
        assert_eq!(
            ascii_compare_ebcdic_order("0", "Z"),
            std::cmp::Ordering::Greater,
            "In EBCDIC, digit '0' should sort AFTER uppercase 'Z'"
        );
    }

    #[test]
    fn test_string_conversion() {
        let ascii = "HELLO WORLD";
        let ebcdic = string_to_ebcdic(ascii);
        let back = ebcdic_to_string(&ebcdic);
        assert_eq!(back, ascii);
    }

    #[test]
    fn test_ebcdic_compare_padding() {
        // "AB" vs "AB   " should be equal (space-padded)
        let a = string_to_ebcdic("AB");
        let b = string_to_ebcdic("AB   ");
        assert_eq!(ebcdic_compare(&a, &b), std::cmp::Ordering::Equal);
    }

    #[test]
    fn test_digits_sort_order() {
        // All digits should sort in order in EBCDIC (0xF0-0xF9)
        for i in 0..9u8 {
            let a = format!("{}", i);
            let b = format!("{}", i + 1);
            assert_eq!(
                ascii_compare_ebcdic_order(&a, &b),
                std::cmp::Ordering::Less,
                "Digit {} should sort before {} in EBCDIC", i, i + 1
            );
        }
    }

    #[test]
    fn test_uppercase_contiguous_groups() {
        // EBCDIC uppercase is NOT contiguous (A-I, J-R, S-Z in separate groups)
        // But within each group, order should be preserved
        assert!(A2E[b'A' as usize] < A2E[b'I' as usize], "A < I in EBCDIC");
        assert!(A2E[b'J' as usize] < A2E[b'R' as usize], "J < R in EBCDIC");
        assert!(A2E[b'S' as usize] < A2E[b'Z' as usize], "S < Z in EBCDIC");
        // Cross-group: I < J
        assert!(A2E[b'I' as usize] < A2E[b'J' as usize], "I < J in EBCDIC");
        // Cross-group: R < S
        assert!(A2E[b'R' as usize] < A2E[b'S' as usize], "R < S in EBCDIC");
    }

    #[test]
    fn test_in_place_conversion() {
        let mut buf = b"COBOL".to_vec();
        ascii_to_ebcdic_buf(&mut buf);
        // C=0xC3, O=0xD6, B=0xC2, O=0xD6, L=0xD3
        assert_eq!(buf, vec![0xC3, 0xD6, 0xC2, 0xD6, 0xD3]);
        ebcdic_to_ascii_buf(&mut buf);
        assert_eq!(&buf, b"COBOL");
    }
}
