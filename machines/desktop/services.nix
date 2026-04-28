{ config, lib, ... }:

let
  nvidia-smi = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi";
  gpu = "0"; 
  watts = "165";
in
{
  hardware.nvidia.nvidiaPersistenced = true;

  systemd.services.nvidia-power-limit = {
    description = "Set gpu power limit";
    wantedBy = [ "multi-user.target" ];
    after = [ "nvidia-persistenced.service" ];
    wants = [ "nvidia-persistenced.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${nvidia-smi} -i ${gpu} -pl ${watts}";
      RemainAfterExit = true;
    };
  };
}
