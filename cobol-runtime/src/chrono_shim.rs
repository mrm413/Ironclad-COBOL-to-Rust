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
    microsecond: u32, // microseconds within the current second (0..999999)
}

impl Local {
    pub fn now() -> DateTime {
        // Mock-clock support: COB_CURRENT_DATE env var (matching GnuCOBOL)
        // overrides the system clock with a fixed timestamp. Format:
        // YYYYMMDD or YYYYMMDDHHMMSS or YYYYMMDDHHMMSS.uuuuuu (microseconds).
        // Used by deterministic tests and the run_accept_002 test family.
        if let Ok(s) = std::env::var("COB_CURRENT_DATE") {
            if let Some(dt) = parse_cob_current_date(&s) {
                return dt;
            }
        }
        let dur = SystemTime::now()
            .duration_since(SystemTime::UNIX_EPOCH)
            .unwrap_or_default();
        let secs = dur.as_secs() as i64;
        let microsecond = (dur.subsec_micros()) as u32;

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
            microsecond,
        }
    }
}

/// Returns the current year (e.g. 2026) as i64 for DATE-TO-YYYY functions.
pub fn current_year() -> i64 {
    Local::now().year as i64
}

fn is_leap(y: i32) -> bool {
    (y % 4 == 0 && y % 100 != 0) || y % 400 == 0
}

/// Parse a COB_CURRENT_DATE string. Accepts YYYYMMDD, YYYYMMDDHHMMSS, or
/// YYYYMMDDHHMMSS.uuuuuu (microseconds optional). Returns None for malformed
/// input — caller falls back to system clock.
fn parse_cob_current_date(s: &str) -> Option<DateTime> {
    let s = s.trim();
    let digits: String = s.chars().take(14).filter(|c| c.is_ascii_digit()).collect();
    if digits.len() < 8 { return None; }
    let year: i32 = digits.get(0..4)?.parse().ok()?;
    let month: u32 = digits.get(4..6)?.parse().ok()?;
    let day: u32 = digits.get(6..8)?.parse().ok()?;
    let hour: u32 = digits.get(8..10).and_then(|x| x.parse().ok()).unwrap_or(0);
    let minute: u32 = digits.get(10..12).and_then(|x| x.parse().ok()).unwrap_or(0);
    let second: u32 = digits.get(12..14).and_then(|x| x.parse().ok()).unwrap_or(0);
    let microsecond: u32 = if let Some(dot) = s.find('.') {
        s[dot+1..].chars().take(6).filter(|c| c.is_ascii_digit())
            .collect::<String>().parse().unwrap_or(0)
    } else { 0 };
    Some(DateTime { year, month, day, hour, minute, second, microsecond })
}

impl DateTime {
    fn day_of_year(&self) -> u32 {
        let leap = is_leap(self.year);
        let month_days: [u32; 12] = [
            31, if leap { 29 } else { 28 },
            31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
        ];
        let mut doy = self.day;
        for i in 0..(self.month as usize - 1).min(11) {
            doy += month_days[i];
        }
        doy
    }

    fn weekday_iso(&self) -> u32 {
        // Zeller's formula: 1=Monday..7=Sunday (ISO)
        let (y, m) = if self.month <= 2 {
            (self.year - 1, self.month + 12)
        } else {
            (self.year, self.month)
        };
        let q = self.day as i32;
        let k = y % 100;
        let j = y / 100;
        let h = (q + (13 * (m as i32 + 1)) / 5 + k + k / 4 + j / 4 - 2 * j) % 7;
        // h: 0=Sat,1=Sun,2=Mon,...,6=Fri → ISO: 1=Mon..7=Sun
        let iso = ((h + 5) % 7) + 1;
        iso as u32
    }

    pub fn format(&self, fmt: &str) -> FormattedDate {
        let s = match fmt {
            "%y%m%d" => format!("{:02}{:02}{:02}", self.year % 100, self.month, self.day),
            "%Y%m%d" => format!("{:04}{:02}{:02}", self.year, self.month, self.day),
            "%H%M%S%2f" => {
                let hundredths = self.microsecond / 10000; // 0..99
                format!("{:02}{:02}{:02}{:02}", self.hour, self.minute, self.second, hundredths)
            }
            "%H%M%S00" => {
                let hundredths = self.microsecond / 10000; // 0..99
                format!("{:02}{:02}{:02}{:02}", self.hour, self.minute, self.second, hundredths)
            }
            // MICROSECOND-TIME: HHMMSSnnnnnn (12 digits: time with microsecond precision)
            "%H%M%S%6f" => format!("{:02}{:02}{:02}{:06}", self.hour, self.minute, self.second, self.microsecond),
            "%y" => format!("{:02}", self.year % 100),
            "%Y" => format!("{:04}", self.year),
            "%y%j" => format!("{:02}{:03}", self.year % 100, self.day_of_year()),
            "%Y%j" => format!("{:04}{:03}", self.year, self.day_of_year()),
            "%j" => format!("{:03}", self.day_of_year()),
            "%u" => format!("{}", self.weekday_iso()),
            "%z" => "+0000".to_string(), // UTC offset (shim always UTC)
            // COBOL FUNCTION WHEN-COMPILED: YYYYMMDDHHMMSScc (16 chars)
            "%Y%m%d%H%M%S00" => {
                let hundredths = self.microsecond / 10000;
                format!("{:04}{:02}{:02}{:02}{:02}{:02}{:02}",
                    self.year, self.month, self.day, self.hour, self.minute, self.second, hundredths)
            }
            // COBOL FUNCTION CURRENT-DATE: YYYYMMDDHHMMSScc+HHMM (21 chars)
            "%Y%m%d%H%M%S00%z" => {
                let hundredths = self.microsecond / 10000;
                format!("{:04}{:02}{:02}{:02}{:02}{:02}{:02}+0000",
                    self.year, self.month, self.day, self.hour, self.minute, self.second, hundredths)
            }
            // WHEN-COMPILED special register: DD/MM/YYhh.mm.ss (16 chars)
            "%d/%m/%y%H.%M.%S" => format!("{:02}/{:02}/{:02}{:02}.{:02}.{:02}",
                self.day, self.month, self.year % 100, self.hour, self.minute, self.second),
            _ => format!("{:04}-{:02}-{:02}", self.year, self.month, self.day),
        };
        FormattedDate(s)
    }
}

pub struct FormattedDate(String);

impl FormattedDate {
    #[allow(clippy::inherent_to_string_shadow_display)]
    pub fn to_string(&self) -> String {
        self.0.clone()
    }
}

impl std::fmt::Display for FormattedDate {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}
