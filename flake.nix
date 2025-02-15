{
  description = "A collection of MissionCtrl's pre-configured tools";

  inputs = {
    mctrl-formatter.url = "github:nikmctrl/mctrl-formatter";
  };

  outputs = { self, mctrl-formatter, ... }: mctrl-formatter;
}
