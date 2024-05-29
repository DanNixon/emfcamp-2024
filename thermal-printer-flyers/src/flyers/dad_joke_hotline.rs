use super::PrintableFlyer;
use escpos::{driver::Driver, printer::Printer, utils::JustifyMode};

pub(super) struct DadJokeHotline {}

impl PrintableFlyer for DadJokeHotline {
    fn print<D: Driver>(&self, printer: &mut Printer<D>) -> anyhow::Result<()> {
        printer
            .bit_image("./src/flyers/dadjoke.jpg")?
            .feed()?
            .justify(JustifyMode::CENTER)?
            .writeln("Do you enjoy jokes that only your")?
            .writeln("father finds remotely amusing?")?
            .feed()?
            .justify(JustifyMode::LEFT)?
            .bold(true)?
            .writeln("If so, call the")?
            .justify(JustifyMode::CENTER)?
            .size(2, 2)?
            .writeln("DAD JOKE HOTLINE")?
            .justify(JustifyMode::RIGHT)?
            .size(1, 1)?
            .writeln("now!")?
            .justify(JustifyMode::CENTER)?
            .writeln("Telephone")?
            .size(2, 2)?
            .writeln("5653 (JOKE)")?;

        Ok(())
    }
}
