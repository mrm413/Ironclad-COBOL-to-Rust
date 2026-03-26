// chrono_shim — Minimal date/time types for COBOL ACCEPT DATE/TIME.
// When chrono is available, re-exports it. Otherwise provides a simple shim.

use std::time::SystemTime;

pub struct Local;

pub struct DateTime {
    year: i32,
    month: u32,
    day: u32,
    hour: u32,
    minute: u32,
    second: u32,
}

impl Local {
    pub fn now() -> DateTime {
        let dur = SystemTime::now()
            .duration_since(SystemTime::UNIX_EPOCH)
            .unwrap_or_default();
        let secs = dur.as_secs() as i64;

        // Simple civil time calculation (UTC)
        let days = secs / 86400;
        let time_of_day = (secs % 86400) as u32;

        let hour = time_of_day / 3600;
        let minute = (time_of_day % 3600) / 60;
        let second = time_of_day % 60;

        // Days since 1970-01-01
        let mut y = 1970i32;
        let mut remaining_days = days;

        loop {
            let year_days = if is_leap(y) { 366 } else { 365 };
            if remaining_days < year_days {
                break;
            }
            remaining_days -= year_days;
            y += 1;
        }

        let leap = is_leap(y);
        let month_days: [i64; 12] = [
            31,
            if leap { 29 } else { 28 },
            31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
        ];

        let mut m = 0u32;
        for md in &month_days {
            if remaining_days < *md {
                break;
            }
            remaining_days -= *md;
            m += 1;
        }

        DateTime {
            year: y,
            month: m + 1,
            day: remaining_days as u32 + 1,
            hour,
            minute,
            second,
        }
    }
}

fn is_leap(y: i32) -> bool {
    (y % 4 == 0 && y % 100 != 0) || y % 400 == 0
}

impl DateTime {
    pub fn format(&self, fmt: &str) -> FormattedDate {
        let s = match fmt {
            "%y%m%d" => format!("{:02}{:02}{:02}", self.year % 100, self.month, self.day),
            "%Y%m%d" => format!("{:04}{:02}{:02}", self.year, self.month, self.day),
            "%H%M%S00" => format!("{:02}{:02}{:02}00", self.hour, self.minute, self.second),
            "%H%M%S%2f" => format!("{:02}{:02}{:02}00", self.hour, self.minute, self.second),
            _ => format!("{:04}-{:02}-{:02}", self.year, self.month, self.day),
        };
        FormattedDate(s)
    }
}

pub struct FormattedDate(String);

impl std::fmt::Display for FormattedDate {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}
