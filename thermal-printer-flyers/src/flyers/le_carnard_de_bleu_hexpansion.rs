use super::PrintableFlyer;
use escpos::{driver::Driver, printer::Printer, utils::JustifyMode};

pub(super) struct LeCarnardDeBleuHexpansion {}

impl PrintableFlyer for LeCarnardDeBleuHexpansion {
    fn print<D: Driver>(&self, printer: &mut Printer<D>) -> anyhow::Result<()> {
        printer
            .justify(JustifyMode::CENTER)?
            .size(4, 4)?
            .bold(true)?
            .writeln("Got Duck?")?
            .bit_image("./src/flyers/duck.png")?
            .justify(JustifyMode::LEFT)?
            .size(1, 1)?
            .bold(false)?
            .writeln("Your badge needs some top tier art.")?
            .writeln("Art that will topple the entire art world.")?
            .writeln("Art of an animal you can shoot.")?
            .writeln("Art of something big.")?
            .writeln("Art of something you can eat.")?
            .writeln("Art with lots of blue.")?
            .feed()?
            .bold(true)?
            .writeln("Come get")?
            .justify(JustifyMode::CENTER)?
            .size(2, 2)?
            .writeln("BLUE DUCK")?
            .writeln("HEXPANSIONS")?
            .justify(JustifyMode::RIGHT)?
            .size(1, 1)?
            .writeln("Today!")?
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
