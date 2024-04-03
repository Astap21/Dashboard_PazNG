#include "suspension.h"
#include "canDataBase/canDataBase.h"
#include <QTimer>
#include <QDebug>

Suspension::Suspension(QObject *parent) : PrimaryBusComponent(parent)
{
    SuspensionState = LampOff;
    SuspensionError = 0;
    kneelingStatus = 0;

}

void Suspension::SuspensionLampControl(){
    previousComponentState = 0;

    previousComponentState = SuspensionState;
    //OLD
//    if (((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelFrontAxle, gMessageName_ASC1)) == 6.0f)
//        || ((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelRearAxle, gMessageName_ASC1)) == 6.0f)) SuspensionState = LampUpperLevel;
//    else if (((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelFrontAxle, gMessageName_ASC1)) == 7.0f)
//             || ((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelRearAxle, gMessageName_ASC1)) == 7.0f)) SuspensionState = LampLowerLevel;
//    else if (gCanDB.checkSignalValue_4bit((gCanDB.GetSignalValueUint32_t(gSignalName_BelowNominalLevelFrontAxle, gMessageName_ASC1)))
//             || (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_BelowNominalLevelRearAxle, gMessageName_ASC1)))) SuspensionState = LampUpperLevelToggle;
//    else if (gCanDB.checkSignalValue_4bit((gCanDB.GetSignalValueUint32_t(gSignalName_AboveNominalLevelRearAxle, gMessageName_ASC1)))
//             || (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_AboveNominalLevelFrontAxle, gMessageName_ASC1)))) SuspensionState = LampLowerLevelToggle;
//    else if (((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelFrontAxle, gMessageName_ASC1)) == 0.0f)
//             || ((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelRearAxle, gMessageName_ASC1)) == 0.0f)) SuspensionState = LampNotNormal;
//    else SuspensionState = LampOff;

    //new
    if (((gCanDB.GetSignalValueUint32_t(gSignalName_AboveNominalLevelFrontAxle, gMessageName_ASC1)) == 1)
        || ((gCanDB.GetSignalValueUint32_t(gSignalName_AboveNominalLevelRearAxle, gMessageName_ASC1)) == 1)) SuspensionState = LampUpperLevel;
    else if (((gCanDB.GetSignalValueUint32_t(gSignalName_BelowNominalLevelFrontAxle, gMessageName_ASC1)) == 1)
             || ((gCanDB.GetSignalValueUint32_t(gSignalName_BelowNominalLevelRearAxle, gMessageName_ASC1)) == 1)) SuspensionState = LampLowerLevel;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_BelowNominalLevelFrontAxle, gMessageName_ASC1) == 2)
             || (gCanDB.GetSignalValueUint32_t(gSignalName_BelowNominalLevelRearAxle, gMessageName_ASC1))== 2) SuspensionState = LampLowerLevelToggle;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_AboveNominalLevelRearAxle, gMessageName_ASC1) == 2)
             || (gCanDB.GetSignalValueUint32_t(gSignalName_AboveNominalLevelFrontAxle, gMessageName_ASC1)) == 2) SuspensionState = LampUpperLevelToggle;
    else if (((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelFrontAxle, gMessageName_ASC1)) == 0.0f)
             || ((gCanDB.GetSignalValueUint32_t(gSignalName_NominalLevelRearAxle, gMessageName_ASC1)) == 0.0f)) SuspensionState = LampNotNormal;
    else SuspensionState = LampOff;
    if (SuspensionState != previousComponentState) emit sendSuspensionStatusToQml(SuspensionState);
}

void Suspension::ReadStateFromCanDB(){
    previousComponentState = 0;

    SuspensionLampControl();

//    previousComponentState = SuspensionError;
//    if (gCanDB.CheckNumberMissedMessages(gMessageName_ASC1) >= 5)  SuspensionError = SuspensionErrorLamp.LampRed;
//    else if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_RedLampSusp1,gMessageName_DM1_suspension))) SuspensionError = SuspensionErrorLamp.LampRed;
//    else if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_RedLampSusp2,gMessageName_DM1_suspension))) SuspensionError = SuspensionErrorLamp.LampRed;
//    else if (gCanDB.checkSignalValue_4bit(gCanDB.GetSignalValueUint32_t(gSignalName_AmberLampSusp,gMessageName_DM1_suspension))) SuspensionError = SuspensionErrorLamp.LampYellow;
//    else SuspensionError = SuspensionErrorLamp.LampOff;
//    if (SuspensionError != previousComponentState) emit sendSuspensionErrorToQml(SuspensionError);

    previousComponentState = kneelingStatus;
    if ((gCanDB.GetSignalValueUint32_t(gSignalName_KneelingInformation, gMessageName_ASC1)) == 0x0E) kneelingStatus = kneelingStatusLamp.LampToggle;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_KneelingInformation, gMessageName_ASC1)) == 1) kneelingStatus = kneelingStatusLamp.LampOn;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_KneelingInformation, gMessageName_ASC1)) == 2) kneelingStatus = kneelingStatusLamp.LampOn;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_KneelingInformation, gMessageName_ASC1)) == 3) kneelingStatus = kneelingStatusLamp.LampOn;
    else if ((gCanDB.GetSignalValueUint32_t(gSignalName_KneelingInformation, gMessageName_ASC1)) == 4) kneelingStatus = kneelingStatusLamp.LampOn;
    //else if ((gCanDB.GetSignalValueUint32_t(gSignalName_KneelingControlModeReq, gMessageName_ASC2)) == 0) kneelingStatus = kneelingStatusLamp.LampAuto;
    else kneelingStatus = kneelingStatusLamp.LampOff;
    if (kneelingStatus != previousComponentState) emit sendKneelingStatusToQml(kneelingStatus);

}
void Suspension::SendStateToQml(){
//    emit sendSuspensionStatusToQml(SuspensionState);
//    emit sendSuspensionErrorToQml(SuspensionError);
}
void Suspension::dashboardLoadFinished(){
    emit sendSuspensionStatusToQml(SuspensionState);
    emit sendSuspensionErrorToQml(SuspensionError);
    emit sendKneelingStatusToQml(kneelingStatus);
}
