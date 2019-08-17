// http://stackoverflow.com/a/34032216/78204

function Controller() {
    installer.autoRejectMessageBoxes();
    installer.setMessageBoxAutomaticAnswer("OverwriteTargetDirectory", QMessageBox.Yes);
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton,3000);
}

Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    //gui.currentPageWidget().TargetDirectoryLineEdit.setText(installer.value("InstallerDirPath") + "/Qt");
	gui.currentPageWidget().TargetDirectoryLineEdit.setText("/opt/Qt5.13.0/");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();

    widget.selectAll();
    widget.deselectComponent('qt.513.src');

    // widget.deselectAll();
    // widget.selectComponent('qt.qt5.13.android_armv7');
    // widget.selectComponent("qt.513.gcc_64");
    // widget.selectComponent("qt.513.qtquickcontrols");
    // widget.selectComponent("qt.513.gcc_64")
    // // widget.selectComponent("qt.513.doc")
    // // widget.selectComponent("qt.513.examples")
    // widget.selectComponent("qt.513.qtcharts")
    // widget.selectComponent("qt.513.qtcharts.gcc_64")
    // widget.selectComponent("qt.513.qtdatavis3d")
    // widget.selectComponent("qt.513.qtdatavis3d.gcc_64")
    // widget.selectComponent("qt.513.qtnetworkauth")
    // widget.selectComponent("qt.513.qtnetworkauth.gcc_64")
    // widget.selectComponent("qt.513.qtpurchasing")
    // widget.selectComponent("qt.513.qtpurchasing.gcc_64")
    // widget.selectComponent("qt.513.qtremoteobjects")
    // widget.selectComponent("qt.513.qtremoteobjects.gcc_64")
    // widget.selectComponent("qt.513.qtscript")
    // widget.selectComponent("qt.513.qtspeech")
    // widget.selectComponent("qt.513.qtspeech.gcc_64")
    // widget.selectComponent("qt.513.qtvirtualkeyboard")
    // widget.selectComponent("qt.513.qtvirtualkeyboard.gcc_64")
    // widget.selectComponent("qt.513.qtwebengine")
    // widget.selectComponent("qt.513.qtwebengine.gcc_64")
    // // widget.selectComponent("qt.513.src")
    // widget.deselectComponent("qt.tools.qtcreator");
    // widget.deselectComponent("qt.513.qt3d");
    // widget.deselectComponent("qt.513.qtcanvas3d");
    // widget.deselectComponent("qt.513.qtlocation");
    // widget.deselectComponent("qt.513.qtquick1");
    // widget.deselectComponent("qt.513.qtscript");
    // widget.deselectComponent("qt.513.qtwebengine");
    // widget.deselectComponent("qt.extras");
    // widget.deselectComponent("qt.tools.doc");
    // widget.deselectComponent("qt.tools.examples")
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
    checkBoxForm.launchQtCreatorCheckBox.checked = false;
}
    gui.clickButton(buttons.FinishButton);
}
