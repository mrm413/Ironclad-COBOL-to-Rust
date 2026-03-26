// COBOL String Operations: STRING, UNSTRING, INSPECT
// Runtime helper functions that work with byte slices.

/// Find effective content of a STRING source given a delimiter.
/// Delimiter empty = DELIMITED BY SIZE (use full content).
/// Otherwise returns bytes up to (not including) first occurrence of delimiter.
pub fn string_delimited<'a>(data: &'a [u8], delimiter: &[u8]) -> &'a [u8] {
    if delimiter.is_empty() {
        return data;
    }
    let dlen = delimiter.len();
    if dlen > data.len() {
        return data;
    }
    for i in 0..=(data.len() - dlen) {
        if &data[i..i + dlen] == delimiter {
            return &data[..i];
        }
    }
    data
}

/// Append source bytes into target starting at position (1-based COBOL pointer).
/// Advances position by number of bytes written. Returns true if overflow occurred.
pub fn string_append(target: &mut [u8], position: &mut usize, source: &[u8]) -> bool {
    let start = position.saturating_sub(1).min(target.len());
    let avail = target.len() - start;
    let copy_len = source.len().min(avail);
    if copy_len > 0 {
        target[start..start + copy_len].copy_from_slice(&source[..copy_len]);
    }
    *position += copy_len;
    source.len() > avail
}

/// UNSTRING result for one target field.
pub struct UnstringField {
    pub content: Vec<u8>,
    pub delimiter: Vec<u8>,
    pub count: usize,
}

/// UNSTRING: split source into fields by delimiters.
/// pointer is 1-based, advanced past consumed content.
/// Returns list of (content, matched_delimiter, char_count).
pub fn cobol_unstring(
    source: &[u8],
    delimiters: &[(&[u8], bool)], // (delimiter, ALL flag)
    max_targets: usize,
    pointer: &mut usize,
) -> Vec<UnstringField> {
    let mut results = Vec::new();
    let mut pos = pointer.saturating_sub(1);

    while results.len() < max_targets {
        if pos >= source.len() {
            break;
        }

        // Find nearest delimiter
        let mut found_at = source.len();
        let mut found_delim: &[u8] = &[];

        for (delim, _) in delimiters {
            if delim.is_empty() {
                continue;
            }
            let dlen = delim.len();
            if dlen > source.len() - pos {
                continue;
            }
            for i in pos..=(source.len() - dlen) {
                if &source[i..i + dlen] == *delim {
                    if i < found_at {
                        found_at = i;
                        found_delim = delim;
                    }
                    break;
                }
            }
        }

        let content = source[pos..found_at].to_vec();
        let count = content.len();
        let delim_matched = found_delim.to_vec();

        results.push(UnstringField {
            content,
            delimiter: delim_matched,
            count,
        });

        if found_at >= source.len() {
            pos = found_at;
            break;
        }

        // Skip past delimiter
        pos = found_at + found_delim.len();

        // Handle ALL: skip consecutive matching delimiters
        for (delim, all) in delimiters {
            if *all && *delim == found_delim {
                while pos + delim.len() <= source.len()
                    && &source[pos..pos + delim.len()] == *delim
                {
                    pos += delim.len();
                }
            }
        }
    }

    *pointer = pos + 1; // back to 1-based
    results
}

// ── INSPECT helpers ─────────────────────────────────────────────

/// Compute the region bounds (start, end) for INSPECT operations.
/// AFTER INITIAL marker: start after first occurrence.
/// BEFORE INITIAL marker: end at first occurrence (searched from start).
pub fn inspect_region_bounds_pub(
    data: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) -> (usize, usize) {
    inspect_region_bounds(data, before, after)
}

fn inspect_region_bounds(
    data: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) -> (usize, usize) {
    let mut start = 0;
    let mut end = data.len();

    if let Some(marker) = after {
        let mlen = marker.len();
        if mlen > 0 && mlen <= data.len() {
            for i in 0..=(data.len() - mlen) {
                if &data[i..i + mlen] == marker {
                    start = i + mlen;
                    break;
                }
            }
        }
    }

    if let Some(marker) = before {
        let mlen = marker.len();
        if mlen > 0 && start + mlen <= data.len() {
            for i in start..=(data.len() - mlen) {
                if &data[i..i + mlen] == marker {
                    end = i;
                    break;
                }
            }
        }
    }

    (start, end)
}

/// INSPECT TALLYING CHARACTERS: count characters in region.
pub fn inspect_tally_characters(
    data: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) -> usize {
    let (start, end) = inspect_region_bounds(data, before, after);
    end.saturating_sub(start)
}

/// INSPECT TALLYING ALL: count non-overlapping occurrences of pattern.
pub fn inspect_tally_all(
    data: &[u8],
    pattern: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) -> usize {
    let (start, end) = inspect_region_bounds(data, before, after);
    if pattern.is_empty() || start >= end {
        return 0;
    }
    let plen = pattern.len();
    let mut count = 0;
    let mut i = start;
    while i + plen <= end {
        if &data[i..i + plen] == pattern {
            count += 1;
            i += plen;
        } else {
            i += 1;
        }
    }
    count
}

/// INSPECT TALLYING LEADING: count leading consecutive occurrences.
pub fn inspect_tally_leading(
    data: &[u8],
    pattern: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) -> usize {
    let (start, end) = inspect_region_bounds(data, before, after);
    if pattern.is_empty() || start >= end {
        return 0;
    }
    let plen = pattern.len();
    let mut count = 0;
    let mut i = start;
    while i + plen <= end && &data[i..i + plen] == pattern {
        count += 1;
        i += plen;
    }
    count
}

/// INSPECT REPLACING ALL: replace all non-overlapping occurrences.
/// Pattern and replacement must be same length.
pub fn inspect_replace_all(
    data: &mut [u8],
    pattern: &[u8],
    replacement: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) {
    let (start, end) = inspect_region_bounds(data, before, after);
    if pattern.is_empty() || pattern.len() != replacement.len() {
        return;
    }
    let plen = pattern.len();
    let mut i = start;
    while i + plen <= end {
        if &data[i..i + plen] == pattern {
            data[i..i + plen].copy_from_slice(replacement);
            i += plen;
        } else {
            i += 1;
        }
    }
}

/// INSPECT REPLACING LEADING: replace leading consecutive occurrences.
pub fn inspect_replace_leading(
    data: &mut [u8],
    pattern: &[u8],
    replacement: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) {
    let (start, end) = inspect_region_bounds(data, before, after);
    if pattern.is_empty() || pattern.len() != replacement.len() {
        return;
    }
    let plen = pattern.len();
    let mut i = start;
    while i + plen <= end && &data[i..i + plen] == pattern {
        data[i..i + plen].copy_from_slice(replacement);
        i += plen;
    }
}

/// INSPECT REPLACING FIRST: replace first occurrence only.
pub fn inspect_replace_first(
    data: &mut [u8],
    pattern: &[u8],
    replacement: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) {
    let (start, end) = inspect_region_bounds(data, before, after);
    if pattern.is_empty() || pattern.len() != replacement.len() {
        return;
    }
    let plen = pattern.len();
    for i in start..=(end.saturating_sub(plen)) {
        if &data[i..i + plen] == pattern {
            data[i..i + plen].copy_from_slice(replacement);
            return;
        }
    }
}

/// INSPECT CONVERTING: translate characters (like Unix tr).
/// Each byte in `from` is mapped to the corresponding byte in `to`.
pub fn inspect_converting(
    data: &mut [u8],
    from: &[u8],
    to: &[u8],
    before: Option<&[u8]>,
    after: Option<&[u8]>,
) {
    let (start, end) = inspect_region_bounds(data, before, after);
    let len = from.len().min(to.len());
    for byte in &mut data[start..end] {
        for j in 0..len {
            if *byte == from[j] {
                *byte = to[j];
                break;
            }
        }
    }
}

// ── Tests ───────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;

    // ── STRING tests ────────────────────────────────────────────

    #[test]
    fn test_string_delimited_by_space() {
        let data = b"HELLO   ";
        let result = string_delimited(data, b" ");
        assert_eq!(result, b"HELLO");
    }

    #[test]
    fn test_string_delimited_by_size() {
        let data = b"HELLO   ";
        let result = string_delimited(data, b"");
        assert_eq!(result, b"HELLO   ");
    }

    #[test]
    fn test_string_delimited_by_literal() {
        let data = b"FIRST,SECOND,THIRD";
        let result = string_delimited(data, b",");
        assert_eq!(result, b"FIRST");
    }

    #[test]
    fn test_string_append_basic() {
        let mut target = [b' '; 20];
        let mut ptr: usize = 1;
        string_append(&mut target, &mut ptr, b"HELLO");
        assert_eq!(ptr, 6);
        assert_eq!(&target[0..5], b"HELLO");

        string_append(&mut target, &mut ptr, b" ");
        string_append(&mut target, &mut ptr, b"WORLD");
        assert_eq!(ptr, 12);
        assert_eq!(&target[0..11], b"HELLO WORLD");
    }

    #[test]
    fn test_string_overflow() {
        let mut target = [b' '; 5];
        let mut ptr: usize = 1;
        let overflow = string_append(&mut target, &mut ptr, b"TOOLONG");
        assert!(overflow);
        assert_eq!(&target, b"TOOLO");
    }

    // ── UNSTRING tests ──────────────────────────────────────────

    #[test]
    fn test_unstring_single_delimiter() {
        let source = b"ONE,TWO,THREE";
        let delimiters: Vec<(&[u8], bool)> = vec![(b",", false)];
        let mut ptr: usize = 1;
        let results = cobol_unstring(source, &delimiters, 3, &mut ptr);
        assert_eq!(results.len(), 3);
        assert_eq!(results[0].content, b"ONE");
        assert_eq!(results[0].delimiter, b",");
        assert_eq!(results[1].content, b"TWO");
        assert_eq!(results[2].content, b"THREE");
    }

    #[test]
    fn test_unstring_all_delimiter() {
        let source = b"A,,,,B";
        let delimiters: Vec<(&[u8], bool)> = vec![(b",", true)];
        let mut ptr: usize = 1;
        let results = cobol_unstring(source, &delimiters, 2, &mut ptr);
        assert_eq!(results.len(), 2);
        assert_eq!(results[0].content, b"A");
        assert_eq!(results[1].content, b"B");
    }

    #[test]
    fn test_unstring_multiple_delimiters() {
        let source = b"A,B;C";
        let delimiters: Vec<(&[u8], bool)> = vec![(b",", false), (b";", false)];
        let mut ptr: usize = 1;
        let results = cobol_unstring(source, &delimiters, 3, &mut ptr);
        assert_eq!(results.len(), 3);
        assert_eq!(results[0].content, b"A");
        assert_eq!(results[0].delimiter, b",");
        assert_eq!(results[1].content, b"B");
        assert_eq!(results[1].delimiter, b";");
        assert_eq!(results[2].content, b"C");
    }

    // ── INSPECT TALLYING tests ──────────────────────────────────

    #[test]
    fn test_inspect_tally_all() {
        assert_eq!(inspect_tally_all(b"ABCABCABC", b"ABC", None, None), 3);
        assert_eq!(inspect_tally_all(b"ABCABCABC", b"AB", None, None), 3);
        assert_eq!(inspect_tally_all(b"ABCABCABC", b"X", None, None), 0);
    }

    #[test]
    fn test_inspect_tally_leading() {
        assert_eq!(inspect_tally_leading(b"000123", b"0", None, None), 3);
        assert_eq!(inspect_tally_leading(b"123000", b"0", None, None), 0);
    }

    #[test]
    fn test_inspect_tally_characters() {
        assert_eq!(inspect_tally_characters(b"HELLO", None, None), 5);
        assert_eq!(
            inspect_tally_characters(b"HELLO WORLD", Some(b" "), None),
            5
        );
        assert_eq!(
            inspect_tally_characters(b"HELLO WORLD", None, Some(b" ")),
            5
        );
    }

    #[test]
    fn test_inspect_tally_with_boundaries() {
        let data = b"ABCXYZDEF";
        // ALL 'Z' AFTER INITIAL 'X' BEFORE INITIAL 'D'
        assert_eq!(inspect_tally_all(data, b"Z", Some(b"D"), Some(b"X")), 1);
        // Region is 'YZ' (after X, before D)
    }

    // ── INSPECT REPLACING tests ─────────────────────────────────

    #[test]
    fn test_inspect_replace_all() {
        let mut data = *b"AABBAABB";
        inspect_replace_all(&mut data, b"A", b"X", None, None);
        assert_eq!(&data, b"XXBBXXBB");
    }

    #[test]
    fn test_inspect_replace_leading() {
        let mut data = *b"000123000";
        inspect_replace_leading(&mut data, b"0", b"*", None, None);
        assert_eq!(&data, b"***123000");
    }

    #[test]
    fn test_inspect_replace_first() {
        let mut data = *b"AABBAABB";
        inspect_replace_first(&mut data, b"A", b"X", None, None);
        assert_eq!(&data, b"XABBAABB");
    }

    #[test]
    fn test_inspect_replace_with_boundary() {
        let mut data = *b"AABBCCAA";
        // Replace ALL 'A' BY 'X' BEFORE INITIAL 'C'
        inspect_replace_all(&mut data, b"A", b"X", Some(b"C"), None);
        assert_eq!(&data, b"XXBBCCAA");
    }

    // ── INSPECT CONVERTING tests ────────────────────────────────

    #[test]
    fn test_inspect_converting() {
        let mut data = *b"abcdef";
        inspect_converting(&mut data, b"abcdef", b"ABCDEF", None, None);
        assert_eq!(&data, b"ABCDEF");
    }

    #[test]
    fn test_inspect_converting_partial() {
        let mut data = *b"Hello World";
        inspect_converting(&mut data, b"lo", b"LO", None, None);
        assert_eq!(&data, b"HeLLO WOrLd");
    }

    #[test]
    fn test_inspect_converting_with_boundary() {
        let mut data = *b"aabbccaa";
        inspect_converting(&mut data, b"a", b"X", Some(b"c"), None);
        // Region: aabb (before 'c'), so only first 4 bytes affected
        assert_eq!(&data, b"XXbbccaa");
    }
}
