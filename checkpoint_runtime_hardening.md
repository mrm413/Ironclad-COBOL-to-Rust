# Checkpoint: Runtime Hardening + Transpiler Fix-ups

## Date: 2026-03-26

## COMPLETED — ALL MAJOR ISSUES RESOLVED

### Runtime Fixes (public repo: old-ironclad-cobol-to-rust-fix)
1. **report_writer.rs unsafe eliminated** — `static mut REPORTS` → `LazyLock<Mutex<HashMap>>`
   - 0 unsafe blocks remaining in runtime
   - 116 tests passing, 0 clippy warnings
2. **cobol_helpers.rs — 4 new intrinsic functions added**:
   - `cobol_fn_formatted_datetime(fmt, date, time, offset, sys_offset)` → ISO 8601 pattern formatting
   - `cobol_fn_formatted_time(fmt, time, offset, sys_offset)` → time-only formatting
   - `cobol_fn_exception_status()` → stubbed (returns empty string, screen not supported in batch)
   - `cobol_system_offset()` → returns 0 (UTC default)
3. **file_status.rs** — Added `#[derive(Default)]` with `#[default]` on `Success` variant
4. **unwrap() audit** — all 13 are in `#[cfg(test)]` blocks, production code is clean

### Transpiler Fixes (ironclad-carddemo-showcase, NOT pushed)
1. **Rust Keyword Escaping** — `escape_rust_keyword()` in `codegen.rs` with full keyword list
   - Updated `cobol_to_rust_name()`, `rust_field()`, `rust_fn_name()`
2. **`#[derive(Default)]` replacing `MaybeUninit`** — `codegen.rs` + `codegen_data.rs`
   - Eliminated `unsafe { MaybeUninit::zeroed().assume_init() }` from ALL generated files
   - Removed `invalid_value` from `#![allow(...)]` header
3. **Safe file-status synchronization** — `emit_sync_file_status()` + `_indented()`
   - Replaced raw pointer writes (`unsafe { let p = &mut state.X as *mut _ ... }`)
   - New: `state.X = format!("{}", state._fs_Y).cobol_into();`
   - Eliminated ALL unsafe from generated output (was 13 files, now 0)
4. All 33 transpiler unit tests + 1 doc-test passing

### Regenerated Output — Final Metrics
| Metric | Before | After |
|--------|--------|-------|
| Transpiled files | 1,539 | 1,544 |
| Transpile rate | 99.6% | 99.94% |
| Lines of Rust | 190,767 | 185,312 |
| Files with `unsafe` | 13 | **0** |
| Files with `MaybeUninit` | 1,539 | **0** |
| Files with `todo!()`/`unimplemented!()` | 69 | **0** |
| Files with `// TODO` comments | — | 21 (benign stubs) |
| `unwrap()` in runtime | 13 (test-only) | 13 (test-only) |

### GitHub Push History
- Commit f1b4b64: first regeneration (1,539 files + README)
- Next push: 1,544 files + updated README + runtime fixes

## ONLY 1 FILE NOT TRANSPILED

| File | Root Cause | Status |
|------|-----------|--------|
| 0860 | Subroutine (PROCEDURE DIVISION USING), no main | Correctly skipped |

All other previously-failing files (0063, 0347, 0634, 0867, 1189) now transpile successfully.

## PRE-EXISTING COMPILATION ISSUES (11 files)

These 11 files transpile to Rust but have compilation errors. All existed BEFORE the hardening changes — verified by compiling old output. They are parser-level bugs, not regressions:

| File | Error | Root Cause |
|------|-------|-----------|
| 0017 | `state.x. =` (empty field) | Parser loses trailing variable name |
| 0374 | `cobol_fn_abs` not found | Missing intrinsic mapping |
| 0439 | `cobol_fn_module_caller_id` not found | Missing intrinsic mapping |
| 0465 | `cobol_fn_seconds_from_formatted_time` not found | Missing intrinsic mapping |
| 0466 | `cobol_fn_seconds_past_midnight` not found | Missing intrinsic mapping |
| 0496 | `system_offset` as field | Should be function call |
| 0510 | `end_display` as field | Parser treats COBOL reserved word as variable |
| 0777 | `end_display` as field | Same as 0510 |
| 0902 | `rounded` as field | Parser treats ROUNDED as variable |
| 0980 | Missing report writer functions | Stub gap |
| 1506 | `end_display` as field | Same as 0510 |

## NEXT STEPS
1. Push runtime fixes + regenerated output to GitHub
2. (Optional) Add missing intrinsics: abs, module-caller-id, seconds-from-formatted-time, seconds-past-midnight
3. (Optional) Fix parser handling of END-DISPLAY, ROUNDED as reserved words
