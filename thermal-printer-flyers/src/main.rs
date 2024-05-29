mod flyers;

use crate::flyers::{Flyer, PrintableFlyer};
use clap::{Args, Parser};
use escpos::{driver::SerialPortDriver, printer::Printer, utils::Protocol};
use std::time::Duration;
use tracing::info;

#[derive(Debug, Parser)]
#[command(version, about)]
struct Cli {
    #[clap(flatten)]
    printer: SerialPrinterOptions,

    /// The flyer to print
    #[clap(long)]
    flyer: Flyer,

    /// Number of flyers to print
    #[clap(long, default_value = "1")]
    quantity: usize,
}

#[derive(Debug, Args)]
struct SerialPrinterOptions {
    /// The serial port that the printer is connected to
    #[arg(long)]
    serial_port: String,

    /// The baud rate the printer is expecting serial communications at
    #[arg(long, default_value = "9600")]
    serial_baud: u32,
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();

    tracing_subscriber::fmt::init();

    // Setup printer
    let mut printer = {
        let driver = SerialPortDriver::open(
            &cli.printer.serial_port,
            cli.printer.serial_baud,
            Some(Duration::from_secs(5)),
        )?;
        Printer::new(driver.clone(), Protocol::default(), None)
    };

    info!("Will print {} {:?} flyers", cli.quantity, cli.flyer);

    for i in 0..cli.quantity {
        info!("Printing flyer {i} out of {}", cli.quantity);

        // Print the flyer
        cli.flyer.print(&mut printer)?;

        // Reset, feed and cut
        printer
            .bold(false)?
            .reset_size()?
            .reset_line_spacing()?
            .feed()?
            .print_cut()?;
    }

    info!("All done!");

    Ok(())
}
