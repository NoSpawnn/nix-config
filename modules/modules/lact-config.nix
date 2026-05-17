{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.lact-oc;
  yaml = pkgs.formats.yaml { };

  mkGPUConfig =
    gpu:
    let
      powerLimitAttrs = lib.optionalAttrs (gpu.powerLimitW != null) { power_cap = gpu.powerLimitW; };
      memClockAttrs =
        lib.optionalAttrs (gpu.memClockMinMHz != null)
          {
            min_memory_clock = builtins.div gpu.memClockMinMHz 2;
          }

          lib.optionalAttrs
          (gpu.memClockMinMHz != null)
          {
            max_memory_clock = builtins.div gpu.memClockMaxMHz 2;
          };
    in
    {
      fan_control_enabled = gpu.enableFanControl;
      power_limit = gpu.powerLimitW;
      voltage_offset = gpu.voltageOffsetMv;
      coreClock = gpu.coreClockOffsetMHz;
      performance_level = gpu.perfLevel;
    }
    // memClockAttrs
    // powerLimitAttrs;
in
{
  options.services.lact-nix = {
    enable = lib.mkEnableOption "LACT with declarative configuration";

    # lact cli list-gpus
    gpus = lib.mkOption {
      description = "Per-GPU LACT configuration";
      type = lib.types.attrsOf (
        lib.types.submodule (
          { name, ... }:
          {
            enableFanControl = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Enable fan control";
            };

            powerLimitW = lib.mkOption {
              type = lib.types.int;
              description = "Power limit in watts";
            };

            voltageOffsetMv = lib.mkOption {
              type = lib.types.int;
              default = 0;
              description = "Voltage offset in millivolts";
            };

            coreClockOffsetMHz = lib.mkOption {
              type = lib.types.int;
              default = 0;
              description = "Core clock offset in MHz";
            };

            memClockMinMHz = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
              description = "Minimum memory clock in MHz";
            };

            memClockMaxMHz = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
              description = "Maximum memory clock in MHz";
            };

            perfLevel = lib.mkOption {
              type = lib.types.enum [
                "auto"
                "highest"
                "lowest"
                "manual"
              ];
              default = "auto";
              description = "Preferred performance level";
            };
          }
        )
      );
    };

    daemon = {
      adminGroup = {
        type = lib.types.str;
        default = "wheel";
      };

      logLevel = lib.mkOption {
        type = lib.types.enum [
          "trace"
          "debug"
          "info"
          "warn"
          "error"
        ];
        default = "info";
        description = "LACT daemon log level";
      };
    };

    clocksCleanupEnable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."lact/config.yaml" = {
      source = yaml.generate "config.yaml" {
        version = 5;
        apply_settings_timer = 5;
        auto_switch_profiles = false;
        gpus = lib.mapAttrs (_: mkGPUConfig) cfg.gpus;
        daemon = {
          admin_group = cfg.daemon.adminGroup;
          log_level = cfg.daemon.logLevel;
          disable_clocks_cleanup = !cfg.daemon.clocksCleanupEnable;
        };
      };
    };
  };
}
