mod dad_joke_hotline;
mod dial_a_schedule;
mod le_carnard_de_bleu_hexpansion;
mod rabbit_hexpansion;

use self::{
    dad_joke_hotline::DadJokeHotline, dial_a_schedule::DialASchedule,
    le_carnard_de_bleu_hexpansion::LeCarnardDeBleuHexpansion, rabbit_hexpansion::RabbitHexpansion,
};
use clap::ValueEnum;
use escpos::{driver::Driver, printer::Printer};

pub(crate) trait PrintableFlyer {
    fn print<D: Driver>(&self, printer: &mut Printer<D>) -> anyhow::Result<()>;
}

#[derive(Debug, Clone, ValueEnum)]
pub(crate) enum Flyer {
    DialASchedule,
    DadJokeHotline,
    LeCarnardDeBleuHexpansion,
    RabbitHexpansion,
}

impl PrintableFlyer for Flyer {
    fn print<D: Driver>(&self, printer: &mut Printer<D>) -> anyhow::Result<()> {
        match self {
            Flyer::DialASchedule => DialASchedule {}.print(printer),
            Flyer::DadJokeHotline => DadJokeHotline {}.print(printer),
            Flyer::LeCarnardDeBleuHexpansion => LeCarnardDeBleuHexpansion {}.print(printer),
            Flyer::RabbitHexpansion => RabbitHexpansion {}.print(printer),
        }
    }
}
