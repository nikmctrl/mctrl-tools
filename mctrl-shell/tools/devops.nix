{ pkgs, ... }:

{
  out.pkgs = with pkgs; [
    s3cmd
    rclone
  ];
}
