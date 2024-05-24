# Schedule MQTT announcer

Announcements of events delivered via MQTT, can be used for all manner of silly things that respond to the schedule.

This documentation is best ingested alongside [that of the MQTT announcer tool](https://github.com/DanNixon/emfcamp-schedule-api/blob/main/mqtt-announcer/README.md).

## Connection details

- Broker: `schedule.emfcamp.dan-nixon.com`
- Port: `18831`
- No authentication required

## Topics

- `emfcamp/schedule/announce/dev/#`: will announce the 2024 schedule starting at pseudorandom points before the actual event (for testing use only, see [`announcer-dev.yml`](./k8s/announcer-dev.yml))
- `emfcamp/schedule/announce/5min/#`: will announce events 5 minutes before their start times
