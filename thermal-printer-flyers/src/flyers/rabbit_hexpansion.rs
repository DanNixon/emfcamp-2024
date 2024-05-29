use super::PrintableFlyer;
use escpos::{driver::Driver, printer::Printer, utils::JustifyMode};

pub(super) struct RabbitHexpansion {}

impl PrintableFlyer for RabbitHexpansion {
    fn print<D: Driver>(&self, printer: &mut Printer<D>) -> anyhow::Result<()> {
        printer
            .bit_image("./src/flyers/rabbit.png")?
            .feed()?
            .justify(JustifyMode::LEFT)?
            .size(1, 1)?
            .bold(false)?
            .writeln("The rabbits have taken over.")?
            .writeln("Show your support of the rabbits with this stylish badge accessory.")?
            .feed()?
            .bold(true)?
            .justify(JustifyMode::CENTER)?
            .size(2, 2)?
            .writeln("RED RABBIT")?
            .writeln("HEXPANSIONS")?
            .justify(JustifyMode::RIGHT)?
            .size(1, 1)?
            .writeln("Available now!")?
            .feed()?
            .justify(JustifyMode::CENTER)?
            .bold(true)?
            .size(2, 2)?
            .writeln("Telephone 5069")?
            .bold(false)?
            .size(1, 1)?
            .writeln("or visit")?
            .size(2, 2)?
            .bold(true)?
            .writeln("The Northern Quarter")?;

        Ok(())
    }
}
