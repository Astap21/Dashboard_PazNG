//Файл сгенерирован автоматически на основе файла C:/Users/user/workspace/python/CanAst/dbcFiles/Dashboard_LiazNG_v1.5.2.dbc, последние изменения Wed Feb  7 16:24:27 2024
#ifndef CANDATABASE_H_
#define CANDATABASE_H_

#include "canDataBase/canDataClass.h"

extern canBus::canSignalStateStruct gCanSignalState;

extern canBus::signalNameCharStruct gSignalName_JointFailure;
extern canBus::signalNameCharStruct gSignalName_JointFoldingAngle;
extern canBus::signalNameCharStruct gSignalName_JointSound;
extern canBus::signalNameCharStruct gSignalName_JointWarning;
extern canBus::messageNameCharStruct gMessageName_ACU_info;

extern canBus::signalNameCharStruct gSignalName_AirCompressorStatus;
extern canBus::signalNameCharStruct gSignalName_AirSuspensionSupplyPressure;
extern canBus::signalNameCharStruct gSignalName_AuxiliaryEquipmentSupplyPressure;
extern canBus::signalNameCharStruct gSignalName_ParkingAirPressure;
extern canBus::signalNameCharStruct gSignalName_ServiceBrakeCircuit1AirPress;
extern canBus::signalNameCharStruct gSignalName_ServiceBrakeCircuit2AirPress;
extern canBus::messageNameCharStruct gMessageName_AIR1;

extern canBus::signalNameCharStruct gSignalName_AmbientAirTemp;
extern canBus::signalNameCharStruct gSignalName_CabInteriorTempA;
extern canBus::signalNameCharStruct gSignalName_CabInteriorTempB;
extern canBus::messageNameCharStruct gMessageName_AMB;

extern canBus::signalNameCharStruct gSignalName_AboveNominalLevelFrontAxle;
extern canBus::signalNameCharStruct gSignalName_AboveNominalLevelRearAxle;
extern canBus::signalNameCharStruct gSignalName_BelowNominalLevelFrontAxle;
extern canBus::signalNameCharStruct gSignalName_BelowNominalLevelRearAxle;
extern canBus::signalNameCharStruct gSignalName_KneelingInformation;
extern canBus::signalNameCharStruct gSignalName_LiftingControlModeFrontAxle;
extern canBus::signalNameCharStruct gSignalName_LiftingControlModeRearAxle;
extern canBus::signalNameCharStruct gSignalName_LoweringControlModeFrontAxle;
extern canBus::signalNameCharStruct gSignalName_LoweringControlModeRearAxle;
extern canBus::signalNameCharStruct gSignalName_NominalLevelFrontAxle;
extern canBus::signalNameCharStruct gSignalName_NominalLevelRearAxle;
extern canBus::messageNameCharStruct gMessageName_ASC1;

extern canBus::signalNameCharStruct gSignalName_ExhaustSystemError;
extern canBus::messageNameCharStruct gMessageName_AT1IG1;

extern canBus::signalNameCharStruct gSignalName_LowUrea;
extern canBus::messageNameCharStruct gMessageName_AT1T1I1;

extern canBus::signalNameCharStruct gSignalName_SeatBeltSwitch;
extern canBus::messageNameCharStruct gMessageName_BDS;

extern canBus::signalNameCharStruct gSignalName_Btn12_Menu;
extern canBus::signalNameCharStruct gSignalName_Btn1_Ok;
extern canBus::signalNameCharStruct gSignalName_Btn2_Back;
extern canBus::signalNameCharStruct gSignalName_Btn3_Left;
extern canBus::signalNameCharStruct gSignalName_Btn4_Right;
extern canBus::signalNameCharStruct gSignalName_Btn5_Vol_P;
extern canBus::signalNameCharStruct gSignalName_Btn6_Vol_M;
extern canBus::messageNameCharStruct gMessageName_BJM1;

extern canBus::signalNameCharStruct gSignalName_CruiseControlActive;
extern canBus::signalNameCharStruct gSignalName_ParkingBrakeState;
extern canBus::signalNameCharStruct gSignalName_WheelBasedVehicleSpeed;
extern canBus::messageNameCharStruct gMessageName_CCVS1;

extern canBus::signalNameCharStruct gSignalName_MirrorHeatLeft;
extern canBus::signalNameCharStruct gSignalName_MirrorHeatRight;
extern canBus::messageNameCharStruct gMessageName_CDC;

extern canBus::signalNameCharStruct gSignalName_SeatHeating;
extern canBus::signalNameCharStruct gSignalName_WindshieldHeating;
extern canBus::messageNameCharStruct gMessageName_CECU_1;

extern canBus::signalNameCharStruct gSignalName_SalonLightning;
extern canBus::messageNameCharStruct gMessageName_CL;

extern canBus::signalNameCharStruct gSignalName_AuxHeaterCoolantPumpReq;
extern canBus::signalNameCharStruct gSignalName_AuxHeaterModeReq;
extern canBus::signalNameCharStruct gSignalName_OperatorSeatDirectionSwitch;
extern canBus::signalNameCharStruct gSignalName_RequestedPercentFanSpeed;
extern canBus::messageNameCharStruct gMessageName_CM1;

extern canBus::signalNameCharStruct gSignalName_RampError;
extern canBus::messageNameCharStruct gMessageName_DC1;

extern canBus::signalNameCharStruct gSignalName_EngineHatchOpen;
extern canBus::messageNameCharStruct gMessageName_DC2;

extern canBus::signalNameCharStruct gSignalName_Door1EmergencyOpening1;
extern canBus::signalNameCharStruct gSignalName_Door1NotDefine;
extern canBus::signalNameCharStruct gSignalName_Door1Open;
extern canBus::signalNameCharStruct gSignalName_Door1Pinching;
extern canBus::messageNameCharStruct gMessageName_DCU1;

extern canBus::signalNameCharStruct gSignalName_Door2EmergencyOpening1;
extern canBus::signalNameCharStruct gSignalName_Door2NotDefine;
extern canBus::signalNameCharStruct gSignalName_Door2Open;
extern canBus::signalNameCharStruct gSignalName_Door2Pinching;
extern canBus::messageNameCharStruct gMessageName_DCU2;

extern canBus::signalNameCharStruct gSignalName_Door3EmergencyOpening1;
extern canBus::signalNameCharStruct gSignalName_Door3NotDefine;
extern canBus::signalNameCharStruct gSignalName_Door3Open;
extern canBus::signalNameCharStruct gSignalName_Door3Pinching;
extern canBus::messageNameCharStruct gMessageName_DCU3;

extern canBus::signalNameCharStruct gSignalName_DD1_ReserveFuelLevel;
extern canBus::messageNameCharStruct gMessageName_DD1_12;

extern canBus::signalNameCharStruct gSignalName_CargoAmbientTemp;
extern canBus::signalNameCharStruct gSignalName_DD1_WasherFluidLow;
extern canBus::messageNameCharStruct gMessageName_DD1_1E;

extern canBus::signalNameCharStruct gSignalName_AirFilterClogged;
extern canBus::signalNameCharStruct gSignalName_EngCoolntTemperatureHighLampCmd;
extern canBus::signalNameCharStruct gSignalName_EngineAmberWarningLamp;
extern canBus::signalNameCharStruct gSignalName_EngineProtectLampCommand;
extern canBus::signalNameCharStruct gSignalName_EngineRedStopLamp;
extern canBus::messageNameCharStruct gMessageName_DLCC1;

extern canBus::signalNameCharStruct gSignalName_LowLevelCoolingLiquid;
extern canBus::messageNameCharStruct gMessageName_DLCD1;

extern canBus::signalNameCharStruct gSignalName_VehicleFuelLevelLowLampData;
extern canBus::messageNameCharStruct gMessageName_DLCD2;

extern canBus::signalNameCharStruct gSignalName_EngineError;
extern canBus::signalNameCharStruct gSignalName_EngineWarning;
extern canBus::messageNameCharStruct gMessageName_DM1_EMS;

extern canBus::signalNameCharStruct gSignalName_EPB_Error;
extern canBus::messageNameCharStruct gMessageName_DM1_EPB;

extern canBus::signalNameCharStruct gSignalName_suspensionError1;
extern canBus::signalNameCharStruct gSignalName_suspensionError2;
extern canBus::signalNameCharStruct gSignalName_suspensionWarning;
extern canBus::messageNameCharStruct gMessageName_DM1_Suspension;

extern canBus::signalNameCharStruct gSignalName_ABS_Active;
extern canBus::signalNameCharStruct gSignalName_ABS_FullyOpeartinal;
extern canBus::signalNameCharStruct gSignalName_ASR_BrakeControlActive;
extern canBus::signalNameCharStruct gSignalName_ASR_EngineControlActive;
extern canBus::signalNameCharStruct gSignalName_ASR_HillHolderSwitch;
extern canBus::signalNameCharStruct gSignalName_ASR_OffRoadSwitch;
extern canBus::signalNameCharStruct gSignalName_ASR_infoSignal;
extern canBus::signalNameCharStruct gSignalName_EBS_RedLamp;
extern canBus::signalNameCharStruct gSignalName_EBS_WarningLamp;
extern canBus::messageNameCharStruct gMessageName_EBC1;

extern canBus::signalNameCharStruct gSignalName_FrontAxleLeft;
extern canBus::signalNameCharStruct gSignalName_FrontAxleRight;
extern canBus::signalNameCharStruct gSignalName_RearAxle1LeftWheel;
extern canBus::signalNameCharStruct gSignalName_RearAxle1RightWheel;
extern canBus::signalNameCharStruct gSignalName_RearAxle2LeftWheel;
extern canBus::signalNameCharStruct gSignalName_RearAxle2RightWheel;
extern canBus::signalNameCharStruct gSignalName_RearAxle3LeftWheel;
extern canBus::signalNameCharStruct gSignalName_RearAxle3RightWheel;
extern canBus::messageNameCharStruct gMessageName_EBC4;

extern canBus::signalNameCharStruct gSignalName_HaltBrakeMode;
extern canBus::signalNameCharStruct gSignalName_HillHolderMode;
extern canBus::messageNameCharStruct gMessageName_EBC5;

extern canBus::signalNameCharStruct gSignalName_RequestOpenRamp1;
extern canBus::signalNameCharStruct gSignalName_RequestOpenRamp2;
extern canBus::messageNameCharStruct gMessageName_EDSC2_2;

extern canBus::signalNameCharStruct gSignalName_EngineSpeed;
extern canBus::messageNameCharStruct gMessageName_EEC1;

extern canBus::signalNameCharStruct gSignalName_EngineOilPressure;
extern canBus::messageNameCharStruct gMessageName_EFL;

extern canBus::signalNameCharStruct gSignalName_AutoHold;
extern canBus::signalNameCharStruct gSignalName_ParkingBrake;
extern canBus::messageNameCharStruct gMessageName_EPBS1;

extern canBus::signalNameCharStruct gSignalName_RetarderBrake;
extern canBus::messageNameCharStruct gMessageName_ERC1;

extern canBus::signalNameCharStruct gSignalName_EngineCoolantTemp;
extern canBus::signalNameCharStruct gSignalName_EngineFuelTemperature1;
extern canBus::signalNameCharStruct gSignalName_EngineOilTemp;
extern canBus::messageNameCharStruct gMessageName_ET1;

extern canBus::signalNameCharStruct gSignalName_EngineCoolantTemperature2;
extern canBus::signalNameCharStruct gSignalName_EngineCoolantTemperature3;
extern canBus::messageNameCharStruct gMessageName_ET4;

extern canBus::signalNameCharStruct gSignalName_TranOutputShaftSpeed;
extern canBus::messageNameCharStruct gMessageName_ETC1;

extern canBus::signalNameCharStruct gSignalName_TransmissionCurrentGear;
extern canBus::messageNameCharStruct gMessageName_ETC2;

extern canBus::signalNameCharStruct gSignalName_AutoTrasmissionError;
extern canBus::messageNameCharStruct gMessageName_ETC7;

extern canBus::signalNameCharStruct gSignalName_EmergHammer_1;
extern canBus::signalNameCharStruct gSignalName_EmergHammer_2;
extern canBus::signalNameCharStruct gSignalName_EmergHammer_3;
extern canBus::signalNameCharStruct gSignalName_EmergHammer_4;
extern canBus::signalNameCharStruct gSignalName_FireExting_1;
extern canBus::signalNameCharStruct gSignalName_FireExting_2;
extern canBus::signalNameCharStruct gSignalName_FireExting_3;
extern canBus::signalNameCharStruct gSignalName_FireExting_4;
extern canBus::messageNameCharStruct gMessageName_FS1;

extern canBus::signalNameCharStruct gSignalName_FrontFogLight;
extern canBus::signalNameCharStruct gSignalName_HighBeamHeadLight;
extern canBus::signalNameCharStruct gSignalName_ImplementOEMOption1Light;
extern canBus::signalNameCharStruct gSignalName_LeftTurnSignalLight;
extern canBus::signalNameCharStruct gSignalName_LowBeamHeadLight;
extern canBus::signalNameCharStruct gSignalName_MarkerLight;
extern canBus::signalNameCharStruct gSignalName_RearFogLight;
extern canBus::signalNameCharStruct gSignalName_RightTurnSignalLight;
extern canBus::signalNameCharStruct gSignalName_RunningLight;
extern canBus::messageNameCharStruct gMessageName_LD;

extern canBus::signalNameCharStruct gSignalName_WaterInFuel;
extern canBus::messageNameCharStruct gMessageName_OI;

extern canBus::signalNameCharStruct gSignalName_FrontNonOperatorWiperSwitch;
extern canBus::signalNameCharStruct gSignalName_FrontOperatorWiperSwitch;
extern canBus::signalNameCharStruct gSignalName_WindshieldWasherOn;
extern canBus::messageNameCharStruct gMessageName_OWW;

extern canBus::signalNameCharStruct gSignalName_HeatingWheel;
extern canBus::messageNameCharStruct gMessageName_SCU2CLM;

extern canBus::signalNameCharStruct gSignalName_EngineIntakeAirHeating;
extern canBus::messageNameCharStruct gMessageName_SHUTDN;

extern canBus::signalNameCharStruct gSignalName_DirectionIndicator;
extern canBus::signalNameCharStruct gSignalName_Driver1TimeRelatedStates;
extern canBus::signalNameCharStruct gSignalName_Driver1WorkingState;
extern canBus::signalNameCharStruct gSignalName_Driver2TimeRelatedStates;
extern canBus::signalNameCharStruct gSignalName_Driver2WorkingState;
extern canBus::signalNameCharStruct gSignalName_DriverCard_Driver1;
extern canBus::signalNameCharStruct gSignalName_DriverCard_Driver2;
extern canBus::signalNameCharStruct gSignalName_HandlingInformation;
extern canBus::signalNameCharStruct gSignalName_SystemEvent;
extern canBus::signalNameCharStruct gSignalName_TachographOutputShaftSpeed;
extern canBus::signalNameCharStruct gSignalName_TachographPerformance;
extern canBus::signalNameCharStruct gSignalName_TachographVehicleSpeed;
extern canBus::signalNameCharStruct gSignalName_VehicleMotion;
extern canBus::signalNameCharStruct gSignalName_VehicleOverspeed;
extern canBus::messageNameCharStruct gMessageName_TCO1;

extern canBus::signalNameCharStruct gSignalName_TireAxis;
extern canBus::signalNameCharStruct gSignalName_TireLocation;
extern canBus::signalNameCharStruct gSignalName_TirePressure;
extern canBus::signalNameCharStruct gSignalName_TireTemp;
extern canBus::messageNameCharStruct gMessageName_TIRE;

extern canBus::signalNameCharStruct gSignalName_AutoTransmissionOverheat;
extern canBus::messageNameCharStruct gMessageName_TRF1;

extern canBus::signalNameCharStruct gSignalName_Day;
extern canBus::signalNameCharStruct gSignalName_Hours;
extern canBus::signalNameCharStruct gSignalName_Minutes;
extern canBus::signalNameCharStruct gSignalName_Month;
extern canBus::signalNameCharStruct gSignalName_Seconds;
extern canBus::signalNameCharStruct gSignalName_Year;
extern canBus::messageNameCharStruct gMessageName_TimeData;

extern canBus::signalNameCharStruct gSignalName_VDC_FullyOperational;
extern canBus::signalNameCharStruct gSignalName_VDC_InfoSignal;
extern canBus::messageNameCharStruct gMessageName_VDC1;

extern canBus::signalNameCharStruct gSignalName_TotalVehicleDistance;
extern canBus::signalNameCharStruct gSignalName_TripDistance;
extern canBus::messageNameCharStruct gMessageName_VDHR;

extern canBus::signalNameCharStruct gSignalName_ActualVoltage_24v;
extern canBus::messageNameCharStruct gMessageName_VEP1;

extern canBus::signalNameCharStruct gSignalName_BtnCirc;
extern canBus::signalNameCharStruct gSignalName_Btn_Action;
extern canBus::signalNameCharStruct gSignalName_Btn_Back;
extern canBus::signalNameCharStruct gSignalName_Btn_Down;
extern canBus::signalNameCharStruct gSignalName_Btn_Left;
extern canBus::signalNameCharStruct gSignalName_Btn_Mode;
extern canBus::signalNameCharStruct gSignalName_Btn_Ok;
extern canBus::signalNameCharStruct gSignalName_Btn_Right;
extern canBus::signalNameCharStruct gSignalName_Btn_Sqr;
extern canBus::signalNameCharStruct gSignalName_Btn_Up;
extern canBus::messageNameCharStruct gMessageName_WHL_1;

extern canBus::signalNameCharStruct gSignalName_KneelingControlModeReq;
extern canBus::signalNameCharStruct gSignalName_ReqRegulationBusFrontAxle;
extern canBus::signalNameCharStruct gSignalName_ReqRegulationBusRearAxle;
extern canBus::messageNameCharStruct gMessageName_ASC2;

extern canBus::signalNameCharStruct gSignalName_BtnBackAns;
extern canBus::signalNameCharStruct gSignalName_BtnMinusAns;
extern canBus::signalNameCharStruct gSignalName_BtnOkAns;
extern canBus::signalNameCharStruct gSignalName_BtnPlusAns;
extern canBus::signalNameCharStruct gSignalName_EstimatedRange;
extern canBus::signalNameCharStruct gSignalName_HearthBeat;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_1;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_2;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_3;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_4;
extern canBus::signalNameCharStruct gSignalName_ProgramSubVersion;
extern canBus::signalNameCharStruct gSignalName_ProgramVersion;
extern canBus::messageNameCharStruct gMessageName_DB_1;

extern canBus::signalNameCharStruct gSignalName_AutoClossingDoors;
extern canBus::signalNameCharStruct gSignalName_DisableSafety;
extern canBus::signalNameCharStruct gSignalName_PassengerDoorControl;
extern canBus::messageNameCharStruct gMessageName_DB_2;

extern CanDataBase gCanDB;
#endif /* CANDATABASE_H_ */

