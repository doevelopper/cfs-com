// http://stackoverflow.com/a/34032216/78204

function Controller() {
    installer.autoRejectMessageBoxes();
    installer.setMessageBoxAutomaticAnswer("OverwriteTargetDirectory", QMessageBox.Yes);
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton,5000);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("Welcome Page component: " + widget);
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.CredentialsPageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("Credentials Page component: " + widget);
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.IntroductionPageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("Introduction Page component: " + widget);
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    var widget = gui.currentPageWidget();
    console.log("Target Directory Page component: " + widget);
    //gui.currentPageWidget().TargetDirectoryLineEdit.setText(installer.value("InstallerDirPath") + "/Qt");
    //gui.currentPageWidget().TargetDirectoryLineEdit.setText(installer.environmentVariable("QT_INSTALL_DIR"));

	gui.currentPageWidget().TargetDirectoryLineEdit.setText("/opt/Qt");
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("Component Selection Page component: " + widget);

    widget.selectAll();
    
    //widget.selectComponent("qt.qt5.5130");
    //widget.selectComponent("qt.qt5.5130.gcc_64");

    //widget.deselectComponent('qt.5130.src');
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
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("license agreement Page component: " + widget);
    
    //gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    
    if (widget != null) {
        widget.AcceptLicenseRadioButton.setChecked(true);
    }    
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("Start Menu Directory Page component: " + widget);
    gui.clickButton(buttons.NextButton,5000);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    var widget = gui.currentPageWidget();
    console.log("Ready For Installation Page component: " + widget);
    gui.clickButton(buttons.NextButton),5000;
}

Controller.prototype.FinishedPageCallback = function() {
    var widget = gui.currentPageWidget();
    console.log("Finished Page component: " + widget);
//    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
//    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
//        checkBoxForm.launchQtCreatorCheckBox.checked = false;
//    }
    if (widget.LaunchQtCreatorCheckBoxForm) {
        widget.LaunchQtCreatorCheckBoxForm.launchQtCreatorCheckBox.setChecked(false);
    }
    gui.clickButton(buttons.FinishButton,5000);
}
