use super::PrintableFlyer;
use escpos::{driver::Driver, printer::Printer, utils::JustifyMode};

pub(super) struct DialASchedule {}

impl PrintableFlyer for DialASchedule {
    fn print<D: Driver>(&self, printer: &mut Printer<D>) -> anyhow::Result<()> {
        printer
            .justify(JustifyMode::CENTER)?
            .size(2, 2)?
            .bold(true)?
            .writeln("Dial-a-Schedule")?
            .bit_image("./src/flyers/calendar.png")?
            .bold(false)?
            .size(1, 1)?
            .writeln("Your convenient source for EMF event news!")?
            .feed()?
            .justify(JustifyMode::CENTER)?
            .bold(true)?
            .justify(JustifyMode::LEFT)?
            .size(1, 1)?
            .writeln("Telephone")?
            .justify(JustifyMode::CENTER)?
            .size(2, 2)?
            .writeln("7243 (SCHD/SCHE)")?
            .size(1, 1)?
            .justify(JustifyMode::RIGHT)?
            .writeln("today!")?;

        Ok(())
    }
}
