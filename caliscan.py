## Refering to https://dynamicmacros.3dcoded.xyz/extras/extras-intro/
## Klipper looks for sections in printer.cfg to load defined in [name]
## It loads the extras name.py from ~/klipper/klippy/extras/name.py

# [caliscan]
# host: 127.0.0.1
# port: 9880
# grid_min
# grid_max

class CaliScan:
    def __init__(self, config):
        # Get the printer config from klipper
        self.printer = config.get_printer()
        self.gcode = self.printer.lookup_object('gcode')
        self.reactor = self.printer.get_reactor()

        # Lets start by sending a message to the console
        self.message = config.get('message', 'Loaded CaliScan Module')

        ## call function when klippy indicates its ready 
        self.printer.register_event_handler("klippy:ready", self._handle_ready)

        # Still register the G-code in case you want it later
        self.gcode.register_command('CALI_SCAN', self._ready_handler)

    def _on_ready(self):
        self.gcode.respond_info(self.message)

    def _ready_handler(self, gcmd):
        waketime = self.reactor.monotonic() + 1
        self.reactor.register_timer(self._greet, waketime)

    def _greet(self, eventtime=None):
        self.gcode.respond_info(self.message)
        return self.reactor.NEVER  # Do not re-run timer

def load_config(config):
    # Entry point for Klippy to load this extra
    return CaliScan(config)
