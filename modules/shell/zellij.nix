_: {
    programs.zellij = {
        enable = true;
        settings = {
            default_mode = "locked";
            keybinds = {
                normal._children = [
                    { bind = { _args = ["alt g"]; _children = [{SwitchToMode._args = ["locked"];}];}; }
                    { bind = { _args = ["alt p"]; _children = [{SwitchToMode._args = ["pane"];}];}; }
                    #{ bind = { _args = ["alt n"]; _children = [{NewPane;}];}; }
                ];
                locked._children = [{
                    bind = { _args = ["alt g"]; _children = [{SwitchToMode._args = ["normal"];}];};
                }];
            };
        };
    };
}