// field_ops — MOVE, arithmetic, display, decimal operations for CobolRecord
//
// Split into submodules for maintainability:
//   move_op    — cobol_move and its internal helpers
//   arithmetic — ArithOp enum and cobol_arithmetic
//   display_fmt — cobol_display, read_as_decimal, write_decimal
//   conversion — numeric parsing, BCD pack/unpack, formatting utilities

mod move_op;
mod arithmetic;
mod display_fmt;
mod conversion;

pub use move_op::*;
pub use arithmetic::*;
pub use display_fmt::*;
pub use conversion::*;
