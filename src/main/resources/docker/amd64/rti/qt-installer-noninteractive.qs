// Emacs mode hint: -*- mode: JavaScript -*-

function Controller() {
    installer.setDefaultPageVisible(QInstaller.Introduction, false);
    installer.setDefaultPageVisible(QInstaller.TargetDirectory, false);
    installer.setDefaultPageVisible(QInstaller.ComponentSelection, false);
    installer.setDefaultPageVisible(QInstaller.LicenseCheck, false);
    installer.setDefaultPageVisible(QInstaller.StartMenuSelection, false);
    installer.setDefaultPageVisible(QInstaller.ReadyForInstallation, false);
    installer.setDefaultPageVisible(QInstaller.PerformInstallation, false);

    installer.autoRejectMessageBoxes();
    installer.setMessageBoxAutomaticAnswer("installationError", QMessageBox.Retry);
    installer.setMessageBoxAutomaticAnswer("installationErrorWithRetry", QMessageBox.Retry);
    installer.setMessageBoxAutomaticAnswer("DownloadError", QMessageBox.Retry);
    installer.setMessageBoxAutomaticAnswer("archiveDownloadError", QMessageBox.Retry);
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    // click delay here because the next button is initially disabled for ~1 second
    gui.clickButton(buttons.NextButton, 3000);
}

Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.currentPageWidget().TargetDirectoryLineEdit.setText("/home/developer/" + "/Qt");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.PerformInstallationPageCallback = function() {
    //console.log("PerformInstallationPageCallback");
    gui.clickButton(buttons.CommitButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    console.log("---------------ComponentSelectionPageCallback");

    function list_packages() {
      var components = installer.components();
      console.log("Available components: " + components.length);
      var packages = ["Packages: "];
      for (var i = 0 ; i < components.length ;i++) {
          packages.push(components[i].name);
      }
      console.log(packages.join(" "));
    }

    list_packages();

    var widget = gui.currentPageWidget();

    console.log(widget);

    widget.selectAll();

    //widget.deselectAll();
    //widget.selectComponent("qt.qt5.5130");
    //widget.selectComponent("qt.qt5.5130.gcc_64");
    //widget.deselectComponent('qt.5130.src');
    // widget.selectComponent('qt.qt5.13.android_armv7');
    // widget.selectComponent("qt.513.gcc_64");
    // widget.selectComponent("qt.513.qtquickcontrols");
    // widget.selectComponent("qt.513.gcc_64")
    // widget.selectComponent("qt.513.doc")
    // widget.selectComponent("qt.513.examples")
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
    // widget.selectComponent("qt.513.src")
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
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm;
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}
