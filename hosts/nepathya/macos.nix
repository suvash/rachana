{ config, pkgs, ... }:

{
  imports = [ ./settings.nix ];

  system = {
    defaults = {

      LaunchServices = { LSQuarantine = true; };

      ".GlobalPreferences" = {
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Sosumi.aiff";
      };

      loginwindow = {
        SHOWFULLNAME = false;
        autoLoginUser = null;
        GuestEnabled = false;
        LoginwindowText = "${config.settings.computername}";
        ShutDownDisabled = false;
        SleepDisabled = false;
        RestartDisabled = false;
        ShutDownDisabledWhileLoggedIn = false;
        PowerOffDisabledWhileLoggedIn = false;
        RestartDisabledWhileLoggedIn = false;
        DisableConsoleAccess = false;
      };

      dock = {
        autohide = true;
        autohide-delay = "0.0";
        autohide-time-modifier = "0.0";
        dashboard-in-overlay = true;
        enable-spring-load-actions-on-all-items = true;
        expose-animation-duration = "0.1";
        expose-group-by-app = false;
        launchanim = false;
        mineffect = "scale";
        minimize-to-application = true;
        mouse-over-hilite-stack = true;
        mru-spaces = false;
        orientation = "bottom";
        show-process-indicators = true;
        showhidden = true;
        show-recents = false;
        static-only = true;
        tilesize = 40;
      };

      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        QuitMenuItem = true;
        "_FXShowPosixPathInTitle" = true;
        FXEnableExtensionChangeWarning = false;
      };

      screencapture = {
        location = "~/.screenshots";
        disable-shadow = true;
      };

      smb = {
        NetBIOSName = "${config.settings.hostname}";
        ServerDescription = "${config.settings.hostname}";
      };

      spaces = { spans-displays = false; };

      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        ActuationStrength = 1;
        FirstClickThreshold = 0;
        SecondClickThreshold = 1;
      };

      # universalaccess = {
      #   reduceTransparency = true;
      #   closeViewScrollWheelToggle = true;
      #   closeViewZoomFollowsFocus = true;
      # };

      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        AppleFontSmoothing = 1; # Need to experiment with this
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false; # In favour of key repeat
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDisableAutomaticTermination = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 2;
        NSTextShowsControlCharacters = true;
        NSUseAnimatedFocusRing = false;
        NSScrollAnimationEnabled = true;
        NSWindowResizeTime = "0.001";
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        "com.apple.keyboard.fnState" = false;
        # would be nice to merge this in trackpad
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.trackpad.trackpadCornerClickBehavior" = null;
        "com.apple.trackpad.scaling" = "1";
        "com.apple.sound.beep.volume" = "0.7788008"; # 75%
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.springing.enabled" = true;
        "com.apple.springing.delay" = "0.0";
        "com.apple.swipescrolldirection" = true;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleTemperatureUnit = "Celsius";
        _HIHideMenuBar = false;
      };

      # Apple Firewall
      alf = {
        globalstate = 1;
        stealthenabled = 0;
        loggingenabled = 1;
        allowsignedenabled = 1;
        allowdownloadsignedenabled = 0;
      };

    };
  };

}
