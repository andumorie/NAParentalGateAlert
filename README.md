NAParentalGateAlert
===================

Simple parental gate alert useful for kids apps on iOS App Store; uses UIAlertView and blocks

- Provides a "parental gate" useful for kids apps.
- Prompts the user to answer a simple math question before proceeding.
- Uses a UIAlert for the prompt and a block for the action.
- If the user answers correctly, your action is run.
- If user presses cancel or answers incorrectly, the alert simply dismisses.

Example usage:

    NAParentalGateAlert myAlert = [NAParentalGateAlert alertWithAction:^{ //push my gated view }];
    [myAlert show];


Built for ARC.  You can also use in a non-ARC project, just go to
your target > build phases > compiler flags and add the flag -fobjc-arc for this class.

A few localized languages included.  Simply add your language folder and Localizable.strings file
to the NAParentalGateAlert.bundle to support more languages.

MIT License so it's pretty much free as in beer.  Use this code however you like, just don't sue me.
Oh and I like Franziskaner Weissbier, Shiner Bock, and Hoegaarden :)



//---Link to githalytics.com to see page views----------------------------------------------------------------------//
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/4a4dd3bb4aac153bc616fd57f4ac276b "githalytics.com")](http://githalytics.com/natrosoft/NAParentalGateAlert)
//-----------------------------------------------------------------------------------------------------------------//
