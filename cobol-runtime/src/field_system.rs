// field_system.rs — Environment registers, exit/error handlers, exception context, process helpers

use std::sync::Mutex;

struct ExitHandlerEntry {
    name: String,
    priority: u8,
}

static EXIT_HANDLERS: Mutex<Vec<ExitHandlerEntry>> = Mutex::new(Vec::new());
static ERROR_HANDLERS: Mutex<Vec<String>> = Mutex::new(Vec::new());

/// Exception context for CBL_ERROR_PROC handlers.
/// Stores information about the most recent error for FUNCTION EXCEPTION-* intrinsics.
static EXCEPTION_LOCATION: Mutex<String> = Mutex::new(String::new());
static EXCEPTION_STATEMENT: Mutex<String> = Mutex::new(String::new());
static EXCEPTION_STATUS: Mutex<String> = Mutex::new(String::new());
static EXCEPTION_MESSAGE: Mutex<String> = Mutex::new(String::new());
static EXCEPTION_FILE: Mutex<String> = Mutex::new(String::new());
static ENVIRONMENT_NAME_REG: Mutex<String> = Mutex::new(String::new());
static ARGUMENT_NUMBER_REG: Mutex<usize> = Mutex::new(0);

/// PERFORM exit flag — set when a GO TO jumps outside the current PERFORM range,
/// signaling that the PERFORM loop should terminate.
static PERFORM_EXIT: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);

/// Signal that a PERFORM should be abandoned (GO TO outside performed range).
pub fn signal_perform_exit() {
    PERFORM_EXIT.store(true, std::sync::atomic::Ordering::SeqCst);
}

/// Check and clear the perform-exit flag. Returns true if the flag was set.
pub fn check_perform_exit() -> bool {
    PERFORM_EXIT.swap(false, std::sync::atomic::Ordering::SeqCst)
}

/// SECTION exit flag — set by EXIT SECTION, signals to the caller that
/// the remainder of the current SECTION should be skipped. Generated main()
/// checks this between paragraph calls within a section's labeled block.
static SECTION_EXIT: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);

/// Signal that the current SECTION should be exited (EXIT SECTION).
pub fn signal_section_exit() {
    SECTION_EXIT.store(true, std::sync::atomic::Ordering::SeqCst);
}

/// Check and clear the section-exit flag. Returns true if it was set.
pub fn check_section_exit() -> bool {
    SECTION_EXIT.swap(false, std::sync::atomic::Ordering::SeqCst)
}

// Declarative recursion governor — matches GnuCOBOL libcob's 255-deep cap.
// When a USE AFTER ERROR declarative fires recursively (e.g. handler GO TOs
// back into the I/O statement that triggered it), libcob aborts at depth 255.
// We mirror that with a thread-local counter; on overflow we flush and exit
// so stdout matches cobc byte-for-byte.
thread_local! {
    static DECLARATIVE_DEPTH: std::cell::Cell<u32> = const { std::cell::Cell::new(0) };
}

pub fn enter_declarative() {
    DECLARATIVE_DEPTH.with(|d| {
        let v = d.get();
        if v >= 255 {
            use std::io::Write;
            let _ = std::io::stdout().flush();
            let _ = std::io::stderr().flush();
            std::process::exit(1);
        }
        d.set(v + 1);
    });
}

pub fn leave_declarative() {
    DECLARATIVE_DEPTH.with(|d| {
        d.set(d.get().saturating_sub(1));
    });
}

// EC-I-O exception checking state — set by `>>TURN EC-I-O CHECKING ON` and
// cleared by `... OFF`. When on, an unhandled file I/O error (no FILE STATUS,
// no DECLARATIVES) must trigger libcob's fatal-error path. Files *with* a
// FILE STATUS variable still surface errors via that variable; the flag only
// affects the otherwise-silent fall-through case.
thread_local! {
    static EC_IO_CHECK: std::cell::Cell<bool> = const { std::cell::Cell::new(false) };
}

pub fn set_ec_io_check(on: bool) {
    EC_IO_CHECK.with(|c| c.set(on));
}

pub fn ec_io_check_is_on() -> bool {
    EC_IO_CHECK.with(|c| c.get())
}

/// Called from generated READ code at end-of-file when the file has no
/// FILE STATUS variable and no DECLARATIVES handler. If EC-I-O checking
/// is currently ON for the program, abort with a libcob-style message.
pub fn ec_io_eof_check(file_name: &str) {
    if EC_IO_CHECK.with(|c| c.get()) {
        use std::io::Write;
        let _ = std::io::stdout().flush();
        eprintln!("libcob: prog.cob: READ on '{}' failed with status: 10", file_name);
        let _ = std::io::stderr().flush();
        std::process::exit(1);
    }
}

/// Set the current environment-name register (DISPLAY UPON ENVIRONMENT-NAME).
pub fn set_environment_name(name: &str) {
    *ENVIRONMENT_NAME_REG.lock().unwrap() = name.trim().to_string();
}

/// Get the current environment-name register.
pub fn get_environment_name() -> String {
    ENVIRONMENT_NAME_REG.lock().unwrap().clone()
}

/// DISPLAY UPON ENVIRONMENT-VALUE: set the named env var.
pub fn set_environment_value(value: &str) {
    let name = ENVIRONMENT_NAME_REG.lock().unwrap().clone();
    if !name.is_empty() {
        std::env::set_var(&name, value.trim());
    }
}

/// ACCEPT FROM ENVIRONMENT-VALUE: read the named env var.
pub fn get_environment_value() -> String {
    let name = ENVIRONMENT_NAME_REG.lock().unwrap().clone();
    if name.is_empty() {
        String::new()
    } else {
        std::env::var(&name).unwrap_or_default()
    }
}

/// Set the argument-number register (DISPLAY UPON ARGUMENT-NUMBER or SET).
pub fn set_argument_number(n: usize) {
    *ARGUMENT_NUMBER_REG.lock().unwrap() = n;
}

/// ACCEPT FROM ARGUMENT-NUMBER: returns the count of arguments (excluding program name).
pub fn get_argument_number() -> usize {
    let count = std::env::args().count();
    if count > 1 { count - 1 } else { 0 }
}

/// ACCEPT FROM ARGUMENT-VALUE: reads argument at current position.
pub fn get_argument_value() -> String {
    let idx = *ARGUMENT_NUMBER_REG.lock().unwrap();
    let args: Vec<String> = std::env::args().collect();
    if idx > 0 && idx < args.len() {
        args[idx].clone()
    } else {
        String::new()
    }
}

/// Install an exit handler with default priority (no update of existing).
/// Returns 0 on success, -1 if handler already exists.
pub fn cbl_exit_proc_install(handler_name: &str, priority: u8) -> i32 {
    cbl_exit_proc_install_ex(handler_name, priority, false)
}

/// Install with explicit update flag.
/// If `allow_update` is true (flag=3), updates existing handler's priority instead of rejecting.
pub fn cbl_exit_proc_install_ex(handler_name: &str, priority: u8, allow_update: bool) -> i32 {
    let mut handlers = EXIT_HANDLERS.lock().unwrap();
    for entry in handlers.iter_mut() {
        if entry.name.eq_ignore_ascii_case(handler_name) {
            if allow_update {
                entry.priority = priority;
                return 0;
            }
            return -1; // duplicate
        }
    }
    handlers.push(ExitHandlerEntry {
        name: handler_name.to_string(),
        priority,
    });
    0
}

/// Uninstall an exit handler. Returns 0 on success, -1 if not found.
pub fn cbl_exit_proc_uninstall(handler_name: &str) -> i32 {
    let mut handlers = EXIT_HANDLERS.lock().unwrap();
    let before = handlers.len();
    handlers.retain(|e| !e.name.eq_ignore_ascii_case(handler_name));
    if handlers.len() < before { 0 } else { -1 }
}

/// Query exit handler priority. Returns (0, priority) if found, (-1, 0) if not found.
pub fn cbl_exit_proc_query(handler_name: &str) -> (i32, u8) {
    let handlers = EXIT_HANDLERS.lock().unwrap();
    for entry in handlers.iter() {
        if entry.name.eq_ignore_ascii_case(handler_name) {
            return (0, entry.priority);
        }
    }
    (-1, 0)
}

/// Get all exit handlers in priority order (highest priority first, LIFO within same priority).
pub fn get_exit_handlers() -> Vec<String> {
    let handlers = EXIT_HANDLERS.lock().unwrap();
    let mut sorted: Vec<(u8, usize, String)> = handlers.iter().enumerate()
        .map(|(i, e)| (e.priority, i, e.name.clone()))
        .collect();
    // Sort by priority descending, then by insertion order descending (LIFO)
    sorted.sort_by(|a, b| b.0.cmp(&a.0).then(b.1.cmp(&a.1)));
    sorted.into_iter().map(|(_, _, name)| name).collect()
}

/// Check if an exit handler is still registered (not yet uninstalled).
pub fn is_exit_handler_registered(handler_name: &str) -> bool {
    let handlers = EXIT_HANDLERS.lock().unwrap();
    handlers.iter().any(|e| e.name.eq_ignore_ascii_case(handler_name))
}

/// Install an error handler. Returns 0 on success.
pub fn cbl_error_proc_install(handler_name: &str) -> i32 {
    let mut handlers = ERROR_HANDLERS.lock().unwrap();
    // Check for duplicate — silently ignore
    for name in handlers.iter() {
        if name.eq_ignore_ascii_case(handler_name) {
            return 0;
        }
    }
    handlers.push(handler_name.to_string());
    0
}

/// Uninstall an error handler. Returns 0 on success, -1 if not found.
pub fn cbl_error_proc_uninstall(handler_name: &str) -> i32 {
    let mut handlers = ERROR_HANDLERS.lock().unwrap();
    let before = handlers.len();
    handlers.retain(|n| !n.eq_ignore_ascii_case(handler_name));
    if handlers.len() < before { 0 } else { -1 }
}

/// Get all error handlers in LIFO order (last registered first).
pub fn get_error_handlers() -> Vec<String> {
    let handlers = ERROR_HANDLERS.lock().unwrap();
    let mut result = handlers.clone();
    result.reverse();
    result
}

/// Clear all exception context (SET LAST EXCEPTION TO OFF).
pub fn clear_exception() {
    *EXCEPTION_LOCATION.lock().unwrap() = String::new();
    *EXCEPTION_STATEMENT.lock().unwrap() = String::new();
    *EXCEPTION_STATUS.lock().unwrap() = String::new();
    *EXCEPTION_MESSAGE.lock().unwrap() = String::new();
    *EXCEPTION_FILE.lock().unwrap() = String::new();
}

/// Set exception context for error handlers.
pub fn set_exception_context(location: &str, statement: &str, status: &str, message: &str) {
    *EXCEPTION_LOCATION.lock().unwrap() = location.to_string();
    *EXCEPTION_STATEMENT.lock().unwrap() = format!("{:<31}", statement);
    *EXCEPTION_STATUS.lock().unwrap() = format!("{:<31}", status);
    *EXCEPTION_MESSAGE.lock().unwrap() = message.to_string();
}

/// Set exception context for file I/O errors.
/// Note: GnuCOBOL does NOT set EXCEPTION-STATEMENT or EXCEPTION-LOCATION for file I/O.
pub fn set_file_exception(file_name: &str, file_status: &str, _statement: &str, ec_code: &str) {
    *EXCEPTION_FILE.lock().unwrap() = format!("{}{}", file_status, file_name);
    *EXCEPTION_STATUS.lock().unwrap() = format!("{:<31}", ec_code);
}

/// Get the exception location string.
/// FUNCTION EXCEPTION-LOCATION returns trimmed content (dynamic length).
pub fn get_exception_location() -> String {
    let s = EXCEPTION_LOCATION.lock().unwrap().clone();
    let trimmed = s.trim_end();
    if trimmed.is_empty() { " ".to_string() } else { trimmed.to_string() }
}

/// Get the exception statement string.
/// FUNCTION EXCEPTION-STATEMENT returns 31-char padded field.
pub fn get_exception_statement() -> String {
    let s = EXCEPTION_STATEMENT.lock().unwrap().clone();
    if s.is_empty() { format!("{:<31}", "") } else { s }
}

/// Get the exception status string.
/// FUNCTION EXCEPTION-STATUS returns 31-char padded field.
#[inline(never)]
pub fn get_exception_status() -> String {
    let guard = EXCEPTION_STATUS.lock().unwrap();
    let s: String = guard.clone();
    drop(guard);
    if s.is_empty() { " ".repeat(31) } else { s }
}

/// Get the exception file string (status + file name).
pub fn get_exception_file() -> String {
    let s = EXCEPTION_FILE.lock().unwrap().clone();
    if s.is_empty() { "00".to_string() } else { s }
}

/// Get the exception message string (for error handler LINKAGE parameter).
pub fn get_exception_message() -> String {
    EXCEPTION_MESSAGE.lock().unwrap().clone()
}

/// Map a FileStatus code to a COBOL EC (Exception Condition) code string.
pub fn file_status_to_ec(fs: &str) -> &'static str {
    const EC_MAP: &[(&str, &str)] = &[
        ("00", ""),
        ("02", ""),
        ("04", ""),
        ("05", ""),
        ("10", "EC-I-O-AT-END"),
        ("14", "EC-I-O-AT-END"),
        ("21", "EC-I-O-INVALID-KEY"),
        ("22", "EC-I-O-INVALID-KEY"),
        ("23", "EC-I-O-INVALID-KEY"),
        ("24", "EC-I-O-INVALID-KEY"),
        ("30", "EC-I-O-PERMANENT-ERROR"),
        ("34", "EC-I-O-PERMANENT-ERROR"),
        ("35", "EC-I-O-PERMANENT-ERROR"),
        ("37", "EC-I-O-PERMANENT-ERROR"),
        ("38", "EC-I-O-PERMANENT-ERROR"),
        ("39", "EC-I-O-PERMANENT-ERROR"),
        ("41", "EC-I-O-LOGIC-ERROR"),
        ("42", "EC-I-O-LOGIC-ERROR"),
        ("43", "EC-I-O-LOGIC-ERROR"),
        ("44", "EC-I-O-LOGIC-ERROR"),
        ("46", "EC-I-O-LOGIC-ERROR"),
        ("47", "EC-I-O-LOGIC-ERROR"),
        ("48", "EC-I-O-LOGIC-ERROR"),
        ("49", "EC-I-O-LOGIC-ERROR"),
        ("51", "EC-I-O-PERMANENT-ERROR"),
        ("52", "EC-I-O-PERMANENT-ERROR"),
        ("57", "EC-I-O-PERMANENT-ERROR"),
        ("61", "EC-I-O-PERMANENT-ERROR"),
        ("91", "EC-I-O-PERMANENT-ERROR"),
    ];
    for (code, ec) in EC_MAP {
        if fs == *code { return ec; }
    }
    if fs.starts_with('9') { return "EC-I-O-IMP"; }
    "EC-I-O"
}

// ── Subscript/RefMod bounds checking ($SET SSRANGE / NOSSRANGE) ──

use std::sync::atomic::{AtomicBool, Ordering};

static BOUNDS_CHECK_ENABLED: AtomicBool = AtomicBool::new(false);

/// Enable/disable runtime subscript bounds checking ($SET SSRANGE/$SET NOSSRANGE).
pub fn set_bounds_check(enabled: bool) {
    BOUNDS_CHECK_ENABLED.store(enabled, Ordering::SeqCst);
}

/// Check if bounds checking is currently enabled.
pub fn bounds_check_enabled() -> bool {
    BOUNDS_CHECK_ENABLED.load(Ordering::SeqCst)
}

// ── CANCEL statement — subprogram re-initialization tracking ──

static CANCELLED_PROGRAMS: Mutex<Option<std::collections::HashSet<String>>> = Mutex::new(None);

/// Mark a subprogram as cancelled. The next CALL to this program should
/// re-initialize its WORKING-STORAGE to VALUE clauses.
pub fn cancel_program(name: &str) {
    let mut guard = CANCELLED_PROGRAMS.lock().unwrap();
    let set = guard.get_or_insert_with(std::collections::HashSet::new);
    set.insert(name.trim().to_uppercase());
}

/// Check if a subprogram was cancelled and clear the cancelled flag.
/// Returns true if the program was cancelled (caller should re-initialize).
pub fn check_and_clear_cancelled(name: &str) -> bool {
    let mut guard = CANCELLED_PROGRAMS.lock().unwrap();
    if let Some(ref mut set) = *guard {
        set.remove(&name.trim().to_uppercase())
    } else {
        false
    }
}

// ── OMITTED parameter tracking ──

static OMITTED_PARAMS: Mutex<Option<std::collections::HashSet<String>>> = Mutex::new(None);

/// Mark a parameter as OMITTED for the current CALL.
pub fn mark_param_omitted(name: &str) {
    let mut guard = OMITTED_PARAMS.lock().unwrap();
    let set = guard.get_or_insert_with(std::collections::HashSet::new);
    set.insert(name.trim().to_uppercase());
}

/// Clear all omitted parameter markers (call at start of each CALL dispatch).
pub fn clear_omitted_params() {
    let mut guard = OMITTED_PARAMS.lock().unwrap();
    if let Some(ref mut set) = *guard {
        set.clear();
    }
}

/// Check if a parameter was explicitly marked as OMITTED.
pub fn is_param_omitted(name: &str) -> bool {
    let guard = OMITTED_PARAMS.lock().unwrap();
    if let Some(ref set) = *guard {
        set.contains(&name.trim().to_uppercase())
    } else {
        false
    }
}

// ── CBL_GC_FORK / CBL_GC_WAITPID child process management ──

static CHILD_PROCESS: Mutex<Option<std::process::Child>> = Mutex::new(None);

/// Store a spawned child process for later retrieval by CBL_GC_WAITPID.
pub fn set_child_process(child: std::process::Child) {
    *CHILD_PROCESS.lock().unwrap() = Some(child);
}

/// Take the stored child process (consumes it). Returns None if no child was stored.
pub fn take_child_process() -> Option<std::process::Child> {
    CHILD_PROCESS.lock().unwrap().take()
}

/// CBL_GC_FORK — Unix: real fork(); Windows: returns -1 (unsupported).
/// On Unix returns child PID in parent, 0 in child. The child PID is also
/// stashed for later CBL_GC_WAITPID lookup. On Windows always returns -1
/// to match GnuCOBOL's "fork unavailable" signal.
#[cfg(unix)]
pub fn cbl_gc_fork() -> i64 {
    use nix::unistd::{fork, ForkResult};
    match unsafe { fork() } {
        Ok(ForkResult::Parent { child }) => {
            *CHILD_PID.lock().unwrap() = Some(child.as_raw());
            child.as_raw() as i64
        }
        Ok(ForkResult::Child) => 0,
        Err(_) => -1,
    }
}

/// Set by generated `main` when the COBOL program references CBL_GC_WAITPID.
/// Without a WAITPID call, fork emulation is pointless (the parent never
/// waits, output gets orphaned) so we return -1 to match the GnuCOBOL "no
/// fork support" path. With WAITPID, we do real fork emulation.
static FORK_EMULATION_ENABLED: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);

pub fn enable_fork_emulation() {
    FORK_EMULATION_ENABLED.store(true, std::sync::atomic::Ordering::SeqCst);
}

/// Windows fork emulation: re-exec ourselves with `IRONCLAD_COBOL_CHILD=1`
/// in the environment. The child sees the env var, returns 0 from
/// `cbl_gc_fork()`, and naturally takes the COBOL "WHEN ZERO" branch.
/// Stdout is piped so `cbl_gc_waitpid` can replay child output to our
/// own stdout before reporting the exit code.
///
/// Only active when `enable_fork_emulation()` was called from the program's
/// startup — i.e. when the codegen detected a CBL_GC_WAITPID reference.
/// Programs that fork without ever waiting should observe -1 (fork failed)
/// to match the legacy libcob fallback.
#[cfg(not(unix))]
pub fn cbl_gc_fork() -> i64 {
    // Are we already the child? If so, signal that to the COBOL caller.
    if std::env::var("IRONCLAD_COBOL_CHILD").as_deref() == Ok("1") {
        // Clear so any further CALL "CBL_GC_FORK" inside the child behaves
        // normally (returns -1 = "fork failed" — nested fork is not supported).
        std::env::remove_var("IRONCLAD_COBOL_CHILD");
        return 0;
    }
    if !FORK_EMULATION_ENABLED.load(std::sync::atomic::Ordering::SeqCst) {
        return -1;
    }
    let exe = match std::env::current_exe() {
        Ok(p) => p,
        Err(_) => return -1,
    };
    let child = std::process::Command::new(exe)
        .env("IRONCLAD_COBOL_CHILD", "1")
        .stdout(std::process::Stdio::piped())
        .spawn();
    match child {
        Ok(c) => {
            let pid = c.id() as i64;
            *CHILD_PROCESS.lock().unwrap() = Some(c);
            pid
        }
        Err(_) => -1,
    }
}

#[cfg(unix)]
static CHILD_PID: Mutex<Option<i32>> = Mutex::new(None);

/// CBL_GC_WAITPID — wait for the child spawned by cbl_gc_fork.
/// On Unix: real waitpid, returns the child's exit status.
/// On Windows: wait for the spawned re-exec child, replay its captured
/// stdout to our own stdout, return the child's exit code.
#[cfg(unix)]
pub fn cbl_gc_waitpid(_pid: i64) -> i64 {
    use nix::sys::wait::{waitpid, WaitStatus};
    use nix::unistd::Pid;
    let pid_to_wait = CHILD_PID.lock().unwrap().take();
    let target = match pid_to_wait {
        Some(p) => Pid::from_raw(p),
        None if _pid > 0 => Pid::from_raw(_pid as i32),
        _ => return -1,
    };
    match waitpid(target, None) {
        Ok(WaitStatus::Exited(_, code)) => code as i64,
        Ok(_) => 0,
        Err(_) => -1,
    }
}

#[cfg(not(unix))]
pub fn cbl_gc_waitpid(_pid: i64) -> i64 {
    use std::io::Write;
    let mut child = match CHILD_PROCESS.lock().unwrap().take() {
        Some(c) => c,
        None => return -1,
    };
    // Drain the child's stdout and replay it through our own stdout so the
    // test harness sees the child's DISPLAYs in flow with the parent's.
    if let Some(mut out) = child.stdout.take() {
        use std::io::Read;
        let mut buf = Vec::with_capacity(256);
        let _ = out.read_to_end(&mut buf);
        let _ = std::io::stdout().write_all(&buf);
        let _ = std::io::stdout().flush();
    }
    match child.wait() {
        Ok(status) => status.code().unwrap_or(-1) as i64,
        Err(_) => -1,
    }
}

// ── Caller-side parameter size tracking (for C$PARAMSIZE & ANY LENGTH) ──
//
// Each cross-program CALL pushes a Vec<usize> describing the byte-size
// of every USING argument (as it appears in the *caller's* declaration).
// The callee's C$PARAMSIZE handler queries the top of this stack to get
// the actual size of an ANY LENGTH parameter (which the linkage section
// declares as PIC X with size 1).
static PARAM_SIZE_STACK: Mutex<Vec<Vec<usize>>> = Mutex::new(Vec::new());

/// Push the caller-side argument sizes for a CALL about to execute.
pub fn push_param_sizes(sizes: Vec<usize>) {
    PARAM_SIZE_STACK.lock().unwrap().push(sizes);
}

/// Pop the most recently pushed argument-size frame.
pub fn pop_param_sizes() {
    PARAM_SIZE_STACK.lock().unwrap().pop();
}

/// Return the byte-size of the `idx_1based`-th caller argument for the
/// currently-executing CALL, or 0 if no frame / out of bounds.
pub fn current_param_size(idx_1based: usize) -> usize {
    let stack = PARAM_SIZE_STACK.lock().unwrap();
    if idx_1based == 0 { return 0; }
    stack.last()
        .and_then(|v| v.get(idx_1based - 1).copied())
        .unwrap_or(0)
}

// ── Recursion guard for non-RECURSIVE programs ──

static ACTIVE_CALLS: Mutex<Option<std::collections::HashSet<String>>> = Mutex::new(None);

/// Attempt to enter a program. Returns true if the program was NOT already active
/// (i.e., the call is allowed). Returns false if the program IS already active
/// (recursive call to non-RECURSIVE program).
pub fn enter_program(name: &str) -> bool {
    let mut guard = ACTIVE_CALLS.lock().unwrap();
    let set = guard.get_or_insert_with(std::collections::HashSet::new);
    set.insert(name.trim().to_uppercase())
}

/// Mark a program as no longer active (called on GOBACK/EXIT PROGRAM).
pub fn leave_program(name: &str) {
    let mut guard = ACTIVE_CALLS.lock().unwrap();
    if let Some(ref mut set) = *guard {
        set.remove(&name.trim().to_uppercase());
    }
}

// ── Program-Pointer name storage ────────────────────────────────────
// Maps field_name → program/entry name for PROGRAM-POINTER dispatch.
// SET ptr TO ENTRY "name" stores the name, CALL ptr reads it back.
static PROGRAM_POINTERS: Mutex<Option<std::collections::HashMap<String, String>>> = Mutex::new(None);

/// Store a program/entry name for a PROGRAM-POINTER field.
pub fn set_program_pointer(field_name: &str, program_name: &str) {
    let mut guard = PROGRAM_POINTERS.lock().unwrap();
    let map = guard.get_or_insert_with(std::collections::HashMap::new);
    map.insert(field_name.to_uppercase(), program_name.to_string());
}

/// Get the program/entry name stored in a PROGRAM-POINTER field.
pub fn get_program_pointer(field_name: &str) -> Option<String> {
    let guard = PROGRAM_POINTERS.lock().unwrap();
    guard.as_ref().and_then(|map| map.get(&field_name.to_uppercase()).cloned())
}

/// Clear the program-pointer for a field (SET ptr TO NULL).
pub fn clear_program_pointer(field_name: &str) {
    let mut guard = PROGRAM_POINTERS.lock().unwrap();
    if let Some(ref mut map) = *guard {
        map.remove(&field_name.to_uppercase());
    }
}
