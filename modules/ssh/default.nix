{ pkgs, ... }:

{
  programs.ssh.startAgent = true;
  programs.ssh.agentTimeout = null;
}
