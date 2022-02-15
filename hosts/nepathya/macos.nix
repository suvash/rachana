{ config, pkgs, ... }:

{
  system = {
    defaults = {

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
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = "0.6065307"; # 50%
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.trackpad.trackpadCornerClickBehavior" = null;
        "com.apple.trackpad.scaling" = "1";
        "com.apple.springing.enabled" = true;
        "com.apple.springing.delay" = "0.0";
        "com.apple.swipescrolldirection" = true;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleTemperatureUnit = "Celsius";
        _HIHideMenuBar = true;
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
