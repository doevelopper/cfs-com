//
// based on
// http://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server
//
// run the installer with:
// installer --script <this script>
//

function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
}

// Skip the welcome page
// (delayed click, since the "next" button is not immediately enabled)
Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, 1000);
}

// skip the Qt Account credentials page
Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

// skip the introduction page
Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

// set the installation target directory
Controller.prototype.TargetDirectoryPageCallback = function() {
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("/opt/qt/");
    gui.clickButton(buttons.NextButton);
}

// select the components to install
Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();

    widget.selectAll();

	widget.deselectComponent("qt.qt5.5130.src");
	widget.deselectComponent("qt.qt5.5130.android_armv7");
	widget.deselectComponent("qt.qt5.5130.android_x86");
    gui.clickButton(buttons.NextButton);
    //widget.deselectAll();
    //widget.selectComponent("qt.qt5.5130.gcc_64");
}

// accept the license agreement
Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

// install
Controller.prototype.ReadyForInstallationPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
    // do not launch QtCreator
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}
