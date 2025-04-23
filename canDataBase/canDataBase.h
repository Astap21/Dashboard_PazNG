//C:/Users/user/workspace/python/CanAst/dbcFiles/Dashboard_PazNG_v1.1.0.dbc, последние изменения Wed Apr 23 14:44:24 2025
#ifndef CANDATABASE_H_
#define CANDATABASE_H_

#include "canDataBase/canDataClass.h"

extern canBus::canSignalStateStruct gCanSignalState;

extern const canBus::signalNameCharStruct gSignalName_BlindSpot;
extern const canBus::messageNameCharStruct gMessageName_ADAS_1;

extern const canBus::signalNameCharStruct gSignalName_AirCompressorStatus;
extern const canBus::signalNameCharStruct gSignalName_AirSuspensionSupplyPressure;
extern const canBus::signalNameCharStruct gSignalName_AuxiliaryEquipmentSupplyPressure;
extern const canBus::signalNameCharStruct gSignalName_ParkingAirPressure;
extern const canBus::signalNameCharStruct gSignalName_ServiceBrakeCircuit1AirPress;
extern const canBus::signalNameCharStruct gSignalName_ServiceBrakeCircuit2AirPress;
extern const canBus::messageNameCharStruct gMessageName_AIR1;

extern const canBus::signalNameCharStruct gSignalName_AmbientAirTemp;
extern const canBus::signalNameCharStruct gSignalName_CabInteriorTempA;
extern const canBus::signalNameCharStruct gSignalName_CabInteriorTempB;
extern const canBus::messageNameCharStruct gMessageName_AMB;

extern const canBus::signalNameCharStruct gSignalName_AboveNominalLevelFrontAxle;
extern const canBus::signalNameCharStruct gSignalName_AboveNominalLevelRearAxle;
extern const canBus::signalNameCharStruct gSignalName_BelowNominalLevelFrontAxle;
extern const canBus::signalNameCharStruct gSignalName_BelowNominalLevelRearAxle;
extern const canBus::signalNameCharStruct gSignalName_KneelingInformation;
extern const canBus::signalNameCharStruct gSignalName_LiftingControlModeFrontAxle;
extern const canBus::signalNameCharStruct gSignalName_LiftingControlModeRearAxle;
extern const canBus::signalNameCharStruct gSignalName_LoweringControlModeFrontAxle;
extern const canBus::signalNameCharStruct gSignalName_LoweringControlModeRearAxle;
extern const canBus::signalNameCharStruct gSignalName_NominalLevelFrontAxle;
extern const canBus::signalNameCharStruct gSignalName_NominalLevelRearAxle;
extern const canBus::messageNameCharStruct gMessageName_ASC1;

extern const canBus::signalNameCharStruct gSignalName_AutoKneeling;
extern const canBus::messageNameCharStruct gMessageName_ASC2_Rx;

extern const canBus::signalNameCharStruct gSignalName_Aux2;
extern const canBus::messageNameCharStruct gMessageName_AUXIO_R;

extern const canBus::signalNameCharStruct gSignalName_BatteryCharger1State;
extern const canBus::messageNameCharStruct gMessageName_BCH1;

extern const canBus::signalNameCharStruct gSignalName_SeatBeltSwitch;
extern const canBus::messageNameCharStruct gMessageName_BDS;

extern const canBus::signalNameCharStruct gSignalName_Btn12_Menu;
extern const canBus::signalNameCharStruct gSignalName_Btn1_Ok;
extern const canBus::signalNameCharStruct gSignalName_Btn2_Back;
extern const canBus::signalNameCharStruct gSignalName_Btn3_Left;
extern const canBus::signalNameCharStruct gSignalName_Btn4_Right;
extern const canBus::signalNameCharStruct gSignalName_Btn5_Vol_P;
extern const canBus::signalNameCharStruct gSignalName_Btn6_Vol_M;
extern const canBus::messageNameCharStruct gMessageName_BJM1;

extern const canBus::signalNameCharStruct gSignalName_EstimatedRange;
extern const canBus::messageNameCharStruct gMessageName_CCU1_DB;

extern const canBus::signalNameCharStruct gSignalName_RoofTemp;
extern const canBus::signalNameCharStruct gSignalName_SalonTemp_1;
extern const canBus::signalNameCharStruct gSignalName_SalonTemp_2;
extern const canBus::signalNameCharStruct gSignalName_SalonTemp_3;
extern const canBus::messageNameCharStruct gMessageName_CCUT1;

extern const canBus::signalNameCharStruct gSignalName_CruiseControl;
extern const canBus::signalNameCharStruct gSignalName_ParkingBrakeState;
extern const canBus::signalNameCharStruct gSignalName_WheelBasedVehicleSpeed;
extern const canBus::messageNameCharStruct gMessageName_CCVS1;

extern const canBus::signalNameCharStruct gSignalName_VehicleSpeed_03;
extern const canBus::messageNameCharStruct gMessageName_CCVS1_03;

extern const canBus::signalNameCharStruct gSignalName_MirrorHeatLeft;
extern const canBus::signalNameCharStruct gSignalName_MirrorHeatRight;
extern const canBus::messageNameCharStruct gMessageName_CDC;

extern const canBus::signalNameCharStruct gSignalName_SalonLightning;
extern const canBus::messageNameCharStruct gMessageName_CL;

extern const canBus::signalNameCharStruct gSignalName_AuxHeaterCoolantPumpReq;
extern const canBus::signalNameCharStruct gSignalName_AuxHeaterModeReq;
extern const canBus::signalNameCharStruct gSignalName_OperatorSeatDirectionSwitch;
extern const canBus::signalNameCharStruct gSignalName_RequestedPercentFanSpeed;
extern const canBus::messageNameCharStruct gMessageName_CM1;

extern const canBus::signalNameCharStruct gSignalName_HeaterLiquidState;
extern const canBus::messageNameCharStruct gMessageName_CM1_E1;

extern const canBus::signalNameCharStruct gSignalName_RampError;
extern const canBus::messageNameCharStruct gMessageName_DC1;

extern const canBus::signalNameCharStruct gSignalName_EngineHatchOpen;
extern const canBus::messageNameCharStruct gMessageName_DC2;

extern const canBus::signalNameCharStruct gSignalName_DD1_ReserveFuelLevel;
extern const canBus::messageNameCharStruct gMessageName_DD1_12;

extern const canBus::signalNameCharStruct gSignalName_CargoAmbientTemp;
extern const canBus::signalNameCharStruct gSignalName_DD1_WasherFluidLow;
extern const canBus::messageNameCharStruct gMessageName_DD1_1E;

extern const canBus::signalNameCharStruct gSignalName_EngineAmberWarningLC;
extern const canBus::signalNameCharStruct gSignalName_EngineCoolantLevelLowLC;
extern const canBus::signalNameCharStruct gSignalName_EngineCoolantTempHighLC;
extern const canBus::signalNameCharStruct gSignalName_EngineRedStopLC;
extern const canBus::signalNameCharStruct gSignalName_LowLevelSalonLiquid;
extern const canBus::signalNameCharStruct gSignalName_ReadyForUseLC;
extern const canBus::messageNameCharStruct gMessageName_DLCC1;

extern const canBus::signalNameCharStruct gSignalName_Optional1LC;
extern const canBus::signalNameCharStruct gSignalName_Optional2LC;
extern const canBus::signalNameCharStruct gSignalName_Optional3LC;
extern const canBus::signalNameCharStruct gSignalName_Optional4LC;
extern const canBus::signalNameCharStruct gSignalName_VehicleBatteryChargingLC;
extern const canBus::signalNameCharStruct gSignalName_VehicleLimitedPerformanceModeLC;
extern const canBus::messageNameCharStruct gMessageName_DLCC2;

extern const canBus::signalNameCharStruct gSignalName_LowLevel_CL;
extern const canBus::messageNameCharStruct gMessageName_DLDC1;

extern const canBus::signalNameCharStruct gSignalName_EBS_DM_AmberLamp;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_CM;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_FMI;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_Mailfunction;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_OC;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_ProtectLamp;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_RedLamp;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_SPN1;
extern const canBus::signalNameCharStruct gSignalName_EBS_DM_SPN2;
extern const canBus::messageNameCharStruct gMessageName_DM1_EBS;

extern const canBus::signalNameCharStruct gSignalName_EPB_DM_AmberLamp;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_CM;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_FMI;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_Mailfunction;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_OC;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_ProtectLamp;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_RedLamp;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_SPN1;
extern const canBus::signalNameCharStruct gSignalName_EPB_DM_SPN2;
extern const canBus::messageNameCharStruct gMessageName_DM1_EPB;

extern const canBus::signalNameCharStruct gSignalName_susDM_AmberLamp;
extern const canBus::signalNameCharStruct gSignalName_susDM_CM;
extern const canBus::signalNameCharStruct gSignalName_susDM_FMI;
extern const canBus::signalNameCharStruct gSignalName_susDM_Mailfunction;
extern const canBus::signalNameCharStruct gSignalName_susDM_OC;
extern const canBus::signalNameCharStruct gSignalName_susDM_ProtectLamp;
extern const canBus::signalNameCharStruct gSignalName_susDM_RedLamp;
extern const canBus::signalNameCharStruct gSignalName_susDM_SPN1;
extern const canBus::signalNameCharStruct gSignalName_susDM_SPN2;
extern const canBus::messageNameCharStruct gMessageName_DM1_Suspension;

extern const canBus::signalNameCharStruct gSignalName_Door1CapInside;
extern const canBus::signalNameCharStruct gSignalName_Door1CapOutside;
extern const canBus::signalNameCharStruct gSignalName_Door1Close;
extern const canBus::signalNameCharStruct gSignalName_Door1Closing;
extern const canBus::signalNameCharStruct gSignalName_Door1EmgOpening;
extern const canBus::signalNameCharStruct gSignalName_Door1Open;
extern const canBus::signalNameCharStruct gSignalName_Door1Opening;
extern const canBus::signalNameCharStruct gSignalName_Door1Pinching1;
extern const canBus::signalNameCharStruct gSignalName_Door1Pinching2;
extern const canBus::signalNameCharStruct gSignalName_Door1Pinching3;
extern const canBus::signalNameCharStruct gSignalName_Door1RampOpen;
extern const canBus::signalNameCharStruct gSignalName_Door1RqOpenInside;
extern const canBus::signalNameCharStruct gSignalName_Door1RqOpenOutside;
extern const canBus::signalNameCharStruct gSignalName_Door1ValveInside;
extern const canBus::signalNameCharStruct gSignalName_Door1ValveOutside;
extern const canBus::messageNameCharStruct gMessageName_DOZC_1;

extern const canBus::signalNameCharStruct gSignalName_Door2CapInside;
extern const canBus::signalNameCharStruct gSignalName_Door2CapOutside;
extern const canBus::signalNameCharStruct gSignalName_Door2Close;
extern const canBus::signalNameCharStruct gSignalName_Door2Closing;
extern const canBus::signalNameCharStruct gSignalName_Door2EmgOpening;
extern const canBus::signalNameCharStruct gSignalName_Door2Open;
extern const canBus::signalNameCharStruct gSignalName_Door2Opening;
extern const canBus::signalNameCharStruct gSignalName_Door2Pinching1;
extern const canBus::signalNameCharStruct gSignalName_Door2Pinching2;
extern const canBus::signalNameCharStruct gSignalName_Door2Pinching3;
extern const canBus::signalNameCharStruct gSignalName_Door2RampOpen;
extern const canBus::signalNameCharStruct gSignalName_Door2RqOpenInside;
extern const canBus::signalNameCharStruct gSignalName_Door2RqOpenOutside;
extern const canBus::signalNameCharStruct gSignalName_Door2ValveInside;
extern const canBus::signalNameCharStruct gSignalName_Door2ValveOutside;
extern const canBus::messageNameCharStruct gMessageName_DOZC_2;

extern const canBus::signalNameCharStruct gSignalName_ABS_Active;
extern const canBus::signalNameCharStruct gSignalName_ABS_FullyOpeartinal;
extern const canBus::signalNameCharStruct gSignalName_ASR_BrakeControlActive;
extern const canBus::signalNameCharStruct gSignalName_ASR_EngineControlActive;
extern const canBus::signalNameCharStruct gSignalName_ASR_HillHolderSwitch;
extern const canBus::signalNameCharStruct gSignalName_ASR_OffRoadSwitch;
extern const canBus::signalNameCharStruct gSignalName_ASR_infoSignal;
extern const canBus::signalNameCharStruct gSignalName_EBS_RedLamp;
extern const canBus::signalNameCharStruct gSignalName_EBS_WarningLamp;
extern const canBus::signalNameCharStruct gSignalName_TractionControlOverrideSwitch;
extern const canBus::messageNameCharStruct gMessageName_EBC1;

extern const canBus::signalNameCharStruct gSignalName_FrontAxleLeft;
extern const canBus::signalNameCharStruct gSignalName_FrontAxleRight;
extern const canBus::signalNameCharStruct gSignalName_RearAxle1LeftWheel;
extern const canBus::signalNameCharStruct gSignalName_RearAxle1RightWheel;
extern const canBus::signalNameCharStruct gSignalName_RearAxle2LeftWheel;
extern const canBus::signalNameCharStruct gSignalName_RearAxle2RightWheel;
extern const canBus::signalNameCharStruct gSignalName_RearAxle3LeftWheel;
extern const canBus::signalNameCharStruct gSignalName_RearAxle3RightWheel;
extern const canBus::messageNameCharStruct gMessageName_EBC4;

extern const canBus::signalNameCharStruct gSignalName_HaltBrakeMode;
extern const canBus::signalNameCharStruct gSignalName_HillHolderMode;
extern const canBus::messageNameCharStruct gMessageName_EBC5;

extern const canBus::signalNameCharStruct gSignalName_Eco_s;
extern const canBus::messageNameCharStruct gMessageName_ECO;

extern const canBus::signalNameCharStruct gSignalName_RequestOpenRamp1;
extern const canBus::signalNameCharStruct gSignalName_RequestOpenRamp2;
extern const canBus::messageNameCharStruct gMessageName_EDSC2_2;

extern const canBus::signalNameCharStruct gSignalName_ElectricParkingBrake;
extern const canBus::signalNameCharStruct gSignalName_ParkingWorkStatus1;
extern const canBus::signalNameCharStruct gSignalName_ParkingWorkStatus2;
extern const canBus::messageNameCharStruct gMessageName_EPBS1;

extern const canBus::signalNameCharStruct gSignalName_WheelSteerActuatorState;
extern const canBus::messageNameCharStruct gMessageName_ESC2;

extern const canBus::signalNameCharStruct gSignalName_Temp_CL;
extern const canBus::messageNameCharStruct gMessageName_ET1;

extern const canBus::signalNameCharStruct gSignalName_TransmissionCurrentGear;
extern const canBus::messageNameCharStruct gMessageName_ETC2;

extern const canBus::signalNameCharStruct gSignalName_EmergHammer_1;
extern const canBus::signalNameCharStruct gSignalName_EmergHammer_2;
extern const canBus::signalNameCharStruct gSignalName_EmergHammer_3;
extern const canBus::signalNameCharStruct gSignalName_EmergHammer_4;
extern const canBus::signalNameCharStruct gSignalName_FireExting_1;
extern const canBus::signalNameCharStruct gSignalName_FireExting_2;
extern const canBus::signalNameCharStruct gSignalName_FireExting_3;
extern const canBus::signalNameCharStruct gSignalName_FireExting_4;
extern const canBus::messageNameCharStruct gMessageName_FS1;

extern const canBus::signalNameCharStruct gSignalName_HVESS_Current;
extern const canBus::signalNameCharStruct gSignalName_HVESS_VoltageLevel;
extern const canBus::messageNameCharStruct gMessageName_HVESSD1;

extern const canBus::signalNameCharStruct gSignalName_HVESS_FastUpdateSoc;
extern const canBus::messageNameCharStruct gMessageName_HVESSD2;

extern const canBus::signalNameCharStruct gSignalName_AverageCellTemp;
extern const canBus::signalNameCharStruct gSignalName_HighestCellTemp;
extern const canBus::signalNameCharStruct gSignalName_LowestCellTemp;
extern const canBus::messageNameCharStruct gMessageName_HVESSD3;

extern const canBus::signalNameCharStruct gSignalName_ChargeCurrentLimit;
extern const canBus::signalNameCharStruct gSignalName_DischargeCurrentLimit;
extern const canBus::messageNameCharStruct gMessageName_HVESSD5;

extern const canBus::signalNameCharStruct gSignalName_ElectronicTemp;
extern const canBus::messageNameCharStruct gMessageName_HVESSD6;

extern const canBus::signalNameCharStruct gSignalName_HVESS_CenterOfPackContactor;
extern const canBus::signalNameCharStruct gSignalName_HVESS_HvBusConnectionStatus;
extern const canBus::signalNameCharStruct gSignalName_HVESS_HvBusPrechargeRelay;
extern const canBus::signalNameCharStruct gSignalName_HVESS_HvNegativeContactorState;
extern const canBus::signalNameCharStruct gSignalName_HVESS_HvPositiveContactorState;
extern const canBus::messageNameCharStruct gMessageName_HVESSS1;

extern const canBus::signalNameCharStruct gSignalName_IsoTpDataPC;
extern const canBus::messageNameCharStruct gMessageName_ISOTP_PC_ID;

extern const canBus::signalNameCharStruct gSignalName_FrontFogLight;
extern const canBus::signalNameCharStruct gSignalName_HighBeamHeadLight;
extern const canBus::signalNameCharStruct gSignalName_ImplementOEMOption1Light;
extern const canBus::signalNameCharStruct gSignalName_LeftTurnSignalLight;
extern const canBus::signalNameCharStruct gSignalName_LowBeamHeadLight;
extern const canBus::signalNameCharStruct gSignalName_MarkerLight;
extern const canBus::signalNameCharStruct gSignalName_RearFogLight;
extern const canBus::signalNameCharStruct gSignalName_RightTurnSignalLight;
extern const canBus::signalNameCharStruct gSignalName_RunningLight;
extern const canBus::messageNameCharStruct gMessageName_LD;

extern const canBus::signalNameCharStruct gSignalName_LowBeamLightAuto;
extern const canBus::messageNameCharStruct gMessageName_LD_2;

extern const canBus::signalNameCharStruct gSignalName_ElectricEngineTemp;
extern const canBus::messageNameCharStruct gMessageName_MCU2VCU2;

extern const canBus::signalNameCharStruct gSignalName_FrontNonOperatorWiperSwitch;
extern const canBus::signalNameCharStruct gSignalName_FrontOperatorWiperSwitch;
extern const canBus::signalNameCharStruct gSignalName_WindshieldWasherOn;
extern const canBus::messageNameCharStruct gMessageName_OWW;

extern const canBus::signalNameCharStruct gSignalName_PantographModuleState;
extern const canBus::messageNameCharStruct gMessageName_PCM1;

extern const canBus::signalNameCharStruct gSignalName_HeatingWheel;
extern const canBus::messageNameCharStruct gMessageName_SCU2CLM;

extern const canBus::signalNameCharStruct gSignalName_InletWaterTemp;
extern const canBus::signalNameCharStruct gSignalName_OutletWaterTemp;
extern const canBus::signalNameCharStruct gSignalName_TMS_FaultCode;
extern const canBus::signalNameCharStruct gSignalName_TmsMode;
extern const canBus::messageNameCharStruct gMessageName_T2B_TMS1;

extern const canBus::signalNameCharStruct gSignalName_DirectionIndicator;
extern const canBus::signalNameCharStruct gSignalName_Driver1TimeRelatedStates;
extern const canBus::signalNameCharStruct gSignalName_Driver1WorkingState;
extern const canBus::signalNameCharStruct gSignalName_Driver2TimeRelatedStates;
extern const canBus::signalNameCharStruct gSignalName_Driver2WorkingState;
extern const canBus::signalNameCharStruct gSignalName_DriverCard_Driver1;
extern const canBus::signalNameCharStruct gSignalName_DriverCard_Driver2;
extern const canBus::signalNameCharStruct gSignalName_HandlingInformation;
extern const canBus::signalNameCharStruct gSignalName_SystemEvent;
extern const canBus::signalNameCharStruct gSignalName_TachographOutputShaftSpeed;
extern const canBus::signalNameCharStruct gSignalName_TachographPerformance;
extern const canBus::signalNameCharStruct gSignalName_TachographVehicleSpeed;
extern const canBus::signalNameCharStruct gSignalName_VehicleMotion;
extern const canBus::signalNameCharStruct gSignalName_VehicleOverspeed;
extern const canBus::messageNameCharStruct gMessageName_TCO1;

extern const canBus::signalNameCharStruct gSignalName_TcoVehicleSpeed;
extern const canBus::messageNameCharStruct gMessageName_TCO1_EE;

extern const canBus::signalNameCharStruct gSignalName_TireAxis;
extern const canBus::signalNameCharStruct gSignalName_TireLocation;
extern const canBus::signalNameCharStruct gSignalName_TirePressure;
extern const canBus::signalNameCharStruct gSignalName_TireTemp;
extern const canBus::messageNameCharStruct gMessageName_TIRE;

extern const canBus::signalNameCharStruct gSignalName_Energy_for_traction_daily;
extern const canBus::signalNameCharStruct gSignalName_Energy_for_traction_total;
extern const canBus::messageNameCharStruct gMessageName_TTS6;

extern const canBus::signalNameCharStruct gSignalName_Energy_with_recuperation_daily;
extern const canBus::signalNameCharStruct gSignalName_Energy_with_recuperation_total;
extern const canBus::messageNameCharStruct gMessageName_TTS7;

extern const canBus::signalNameCharStruct gSignalName_Energy_recuperation_total;
extern const canBus::signalNameCharStruct gSignalName_Ratio_recup_to_energy_total;
extern const canBus::messageNameCharStruct gMessageName_TTS8;

extern const canBus::signalNameCharStruct gSignalName_Energy_recuperation_daily;
extern const canBus::signalNameCharStruct gSignalName_Ratio_recup_to_energy_daily;
extern const canBus::messageNameCharStruct gMessageName_TTS9;

extern const canBus::signalNameCharStruct gSignalName_VDC_FullyOperational;
extern const canBus::signalNameCharStruct gSignalName_VDC_InformationSignal;
extern const canBus::messageNameCharStruct gMessageName_VDC1;

extern const canBus::signalNameCharStruct gSignalName_ActualVoltage_24v;
extern const canBus::messageNameCharStruct gMessageName_VEP1;

extern const canBus::signalNameCharStruct gSignalName_KneelingControlModeReq;
extern const canBus::signalNameCharStruct gSignalName_ReqRegulationBusFrontAxle;
extern const canBus::signalNameCharStruct gSignalName_ReqRegulationBusRearAxle;
extern const canBus::messageNameCharStruct gMessageName_ASC2_Tx;

extern const canBus::signalNameCharStruct gSignalName_BtnBackAns;
extern const canBus::signalNameCharStruct gSignalName_BtnMinusAns;
extern const canBus::signalNameCharStruct gSignalName_BtnOkAns;
extern const canBus::signalNameCharStruct gSignalName_BtnPlusAns;
extern const canBus::signalNameCharStruct gSignalName_HearthBeat;
extern const canBus::signalNameCharStruct gSignalName_IpAddressByte_1;
extern const canBus::signalNameCharStruct gSignalName_IpAddressByte_2;
extern const canBus::signalNameCharStruct gSignalName_IpAddressByte_3;
extern const canBus::signalNameCharStruct gSignalName_IpAddressByte_4;
extern const canBus::signalNameCharStruct gSignalName_KL_15;
extern const canBus::signalNameCharStruct gSignalName_ProgramBuild;
extern const canBus::signalNameCharStruct gSignalName_ProgramSubVersion;
extern const canBus::signalNameCharStruct gSignalName_ProgramVersion;
extern const canBus::messageNameCharStruct gMessageName_DB_1;

extern const canBus::signalNameCharStruct gSignalName_AutoClossingDoors;
extern const canBus::signalNameCharStruct gSignalName_CpuLoad;
extern const canBus::signalNameCharStruct gSignalName_DisableSafety;
extern const canBus::signalNameCharStruct gSignalName_MemLoad;
extern const canBus::signalNameCharStruct gSignalName_PassengerDoorControl;
extern const canBus::messageNameCharStruct gMessageName_DB_2;

extern const canBus::signalNameCharStruct gSignalName_TurnLeftLamp;
extern const canBus::signalNameCharStruct gSignalName_TurnRightLamp;
extern const canBus::messageNameCharStruct gMessageName_DB_3;

extern const canBus::signalNameCharStruct gSignalName_IsoTpDataDB;
extern const canBus::messageNameCharStruct gMessageName_ISOTP_DASHBOARD_ID;

extern const canBus::signalNameCharStruct gSignalName_TotalVehicleDistance;
extern const canBus::signalNameCharStruct gSignalName_TripDistance;
extern const canBus::messageNameCharStruct gMessageName_VDHR;

extern CanDataBase gCanDB;
#endif /* CANDATABASE_H_ */

