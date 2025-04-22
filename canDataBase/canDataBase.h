//C:/Users/user/workspace/python/CanAst/dbcFiles/Dashboard_PazNG_v1.1.0.dbc, последние изменения Fri Mar  7 16:26:20 2025
#ifndef CANDATABASE_H_
#define CANDATABASE_H_

#include "canDataBase/canDataClass.h"

extern canBus::canSignalStateStruct gCanSignalState;

extern canBus::signalNameCharStruct gSignalName_BlindSpot;
extern canBus::messageNameCharStruct gMessageName_ADAS_1;

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

extern canBus::signalNameCharStruct gSignalName_AutoKneeling;
extern canBus::messageNameCharStruct gMessageName_ASC2_Rx;

extern canBus::signalNameCharStruct gSignalName_Aux2;
extern canBus::messageNameCharStruct gMessageName_AUXIO_R;

extern canBus::signalNameCharStruct gSignalName_BatteryCharger1State;
extern canBus::messageNameCharStruct gMessageName_BCH1;

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

extern canBus::signalNameCharStruct gSignalName_EstimatedRange;
extern canBus::messageNameCharStruct gMessageName_CCU1_DB;

extern canBus::signalNameCharStruct gSignalName_RoofTemp;
extern canBus::signalNameCharStruct gSignalName_SalonTemp_1;
extern canBus::signalNameCharStruct gSignalName_SalonTemp_2;
extern canBus::signalNameCharStruct gSignalName_SalonTemp_3;
extern canBus::messageNameCharStruct gMessageName_CCUT1;

extern canBus::signalNameCharStruct gSignalName_CruiseControl;
extern canBus::signalNameCharStruct gSignalName_ParkingBrakeState;
extern canBus::signalNameCharStruct gSignalName_WheelBasedVehicleSpeed;
extern canBus::messageNameCharStruct gMessageName_CCVS1;

extern canBus::signalNameCharStruct gSignalName_VehicleSpeed_03;
extern canBus::messageNameCharStruct gMessageName_CCVS1_03;

extern canBus::signalNameCharStruct gSignalName_MirrorHeatLeft;
extern canBus::signalNameCharStruct gSignalName_MirrorHeatRight;
extern canBus::messageNameCharStruct gMessageName_CDC;

extern canBus::signalNameCharStruct gSignalName_SalonLightning;
extern canBus::messageNameCharStruct gMessageName_CL;

extern canBus::signalNameCharStruct gSignalName_AuxHeaterCoolantPumpReq;
extern canBus::signalNameCharStruct gSignalName_AuxHeaterModeReq;
extern canBus::signalNameCharStruct gSignalName_OperatorSeatDirectionSwitch;
extern canBus::signalNameCharStruct gSignalName_RequestedPercentFanSpeed;
extern canBus::messageNameCharStruct gMessageName_CM1;

extern canBus::signalNameCharStruct gSignalName_HeaterLiquidState;
extern canBus::messageNameCharStruct gMessageName_CM1_E1;

extern canBus::signalNameCharStruct gSignalName_RampError;
extern canBus::messageNameCharStruct gMessageName_DC1;

extern canBus::signalNameCharStruct gSignalName_EngineHatchOpen;
extern canBus::messageNameCharStruct gMessageName_DC2;

extern canBus::signalNameCharStruct gSignalName_DD1_ReserveFuelLevel;
extern canBus::messageNameCharStruct gMessageName_DD1_12;

extern canBus::signalNameCharStruct gSignalName_CargoAmbientTemp;
extern canBus::signalNameCharStruct gSignalName_DD1_WasherFluidLow;
extern canBus::messageNameCharStruct gMessageName_DD1_1E;

extern canBus::signalNameCharStruct gSignalName_EngineAmberWarningLC;
extern canBus::signalNameCharStruct gSignalName_EngineCoolantLevelLowLC;
extern canBus::signalNameCharStruct gSignalName_EngineCoolantTempHighLC;
extern canBus::signalNameCharStruct gSignalName_EngineRedStopLC;
extern canBus::signalNameCharStruct gSignalName_LowLevelSalonLiquid;
extern canBus::signalNameCharStruct gSignalName_ReadyForUseLC;
extern canBus::messageNameCharStruct gMessageName_DLCC1;

extern canBus::signalNameCharStruct gSignalName_Optional1LC;
extern canBus::signalNameCharStruct gSignalName_Optional2LC;
extern canBus::signalNameCharStruct gSignalName_Optional3LC;
extern canBus::signalNameCharStruct gSignalName_Optional4LC;
extern canBus::signalNameCharStruct gSignalName_VehicleBatteryChargingLC;
extern canBus::signalNameCharStruct gSignalName_VehicleLimitedPerformanceModeLC;
extern canBus::messageNameCharStruct gMessageName_DLCC2;

extern canBus::signalNameCharStruct gSignalName_LowLevel_CL;
extern canBus::messageNameCharStruct gMessageName_DLDC1;

extern canBus::signalNameCharStruct gSignalName_EBS_DM_AmberLamp;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_CM;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_FMI;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_Mailfunction;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_OC;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_ProtectLamp;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_RedLamp;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_SPN1;
extern canBus::signalNameCharStruct gSignalName_EBS_DM_SPN2;
extern canBus::messageNameCharStruct gMessageName_DM1_EBS;

extern canBus::signalNameCharStruct gSignalName_EPB_DM_AmberLamp;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_CM;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_FMI;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_Mailfunction;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_OC;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_ProtectLamp;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_RedLamp;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_SPN1;
extern canBus::signalNameCharStruct gSignalName_EPB_DM_SPN2;
extern canBus::messageNameCharStruct gMessageName_DM1_EPB;

extern canBus::signalNameCharStruct gSignalName_susDM_AmberLamp;
extern canBus::signalNameCharStruct gSignalName_susDM_CM;
extern canBus::signalNameCharStruct gSignalName_susDM_FMI;
extern canBus::signalNameCharStruct gSignalName_susDM_Mailfunction;
extern canBus::signalNameCharStruct gSignalName_susDM_OC;
extern canBus::signalNameCharStruct gSignalName_susDM_ProtectLamp;
extern canBus::signalNameCharStruct gSignalName_susDM_RedLamp;
extern canBus::signalNameCharStruct gSignalName_susDM_SPN1;
extern canBus::signalNameCharStruct gSignalName_susDM_SPN2;
extern canBus::messageNameCharStruct gMessageName_DM1_Suspension;

extern canBus::signalNameCharStruct gSignalName_Door1CapInside;
extern canBus::signalNameCharStruct gSignalName_Door1CapOutside;
extern canBus::signalNameCharStruct gSignalName_Door1Close;
extern canBus::signalNameCharStruct gSignalName_Door1Closing;
extern canBus::signalNameCharStruct gSignalName_Door1EmgOpening;
extern canBus::signalNameCharStruct gSignalName_Door1Open;
extern canBus::signalNameCharStruct gSignalName_Door1Opening;
extern canBus::signalNameCharStruct gSignalName_Door1Pinching1;
extern canBus::signalNameCharStruct gSignalName_Door1Pinching2;
extern canBus::signalNameCharStruct gSignalName_Door1Pinching3;
extern canBus::signalNameCharStruct gSignalName_Door1RqOpenInside;
extern canBus::signalNameCharStruct gSignalName_Door1RqOpenOutside;
extern canBus::signalNameCharStruct gSignalName_Door1ValveInside;
extern canBus::signalNameCharStruct gSignalName_Door1ValveOutside;
extern canBus::messageNameCharStruct gMessageName_DOZC_1;

extern canBus::signalNameCharStruct gSignalName_Door2CapInside;
extern canBus::signalNameCharStruct gSignalName_Door2CapOutside;
extern canBus::signalNameCharStruct gSignalName_Door2Close;
extern canBus::signalNameCharStruct gSignalName_Door2Closing;
extern canBus::signalNameCharStruct gSignalName_Door2EmgOpening;
extern canBus::signalNameCharStruct gSignalName_Door2Open;
extern canBus::signalNameCharStruct gSignalName_Door2Opening;
extern canBus::signalNameCharStruct gSignalName_Door2Pinching1;
extern canBus::signalNameCharStruct gSignalName_Door2Pinching2;
extern canBus::signalNameCharStruct gSignalName_Door2Pinching3;
extern canBus::signalNameCharStruct gSignalName_Door2RampOpen;
extern canBus::signalNameCharStruct gSignalName_Door2RqOpenInside;
extern canBus::signalNameCharStruct gSignalName_Door2RqOpenOutside;
extern canBus::signalNameCharStruct gSignalName_Door2ValveInside;
extern canBus::signalNameCharStruct gSignalName_Door2ValveOutside;
extern canBus::messageNameCharStruct gMessageName_DOZC_2;

extern canBus::signalNameCharStruct gSignalName_ABS_Active;
extern canBus::signalNameCharStruct gSignalName_ABS_FullyOpeartinal;
extern canBus::signalNameCharStruct gSignalName_ASR_BrakeControlActive;
extern canBus::signalNameCharStruct gSignalName_ASR_EngineControlActive;
extern canBus::signalNameCharStruct gSignalName_ASR_HillHolderSwitch;
extern canBus::signalNameCharStruct gSignalName_ASR_OffRoadSwitch;
extern canBus::signalNameCharStruct gSignalName_ASR_infoSignal;
extern canBus::signalNameCharStruct gSignalName_EBS_RedLamp;
extern canBus::signalNameCharStruct gSignalName_EBS_WarningLamp;
extern canBus::signalNameCharStruct gSignalName_TractionControlOverrideSwitch;
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

extern canBus::signalNameCharStruct gSignalName_Eco_s;
extern canBus::messageNameCharStruct gMessageName_ECO;

extern canBus::signalNameCharStruct gSignalName_RequestOpenRamp1;
extern canBus::signalNameCharStruct gSignalName_RequestOpenRamp2;
extern canBus::messageNameCharStruct gMessageName_EDSC2_2;

extern canBus::signalNameCharStruct gSignalName_ElectricParkingBrake;
extern canBus::signalNameCharStruct gSignalName_ParkingWorkStatus1;
extern canBus::signalNameCharStruct gSignalName_ParkingWorkStatus2;
extern canBus::messageNameCharStruct gMessageName_EPBS1;

extern canBus::signalNameCharStruct gSignalName_WheelSteerActuatorState;
extern canBus::messageNameCharStruct gMessageName_ESC2;

extern canBus::signalNameCharStruct gSignalName_Temp_CL;
extern canBus::messageNameCharStruct gMessageName_ET1;

extern canBus::signalNameCharStruct gSignalName_TransmissionCurrentGear;
extern canBus::messageNameCharStruct gMessageName_ETC2;

extern canBus::signalNameCharStruct gSignalName_EmergHammer_1;
extern canBus::signalNameCharStruct gSignalName_EmergHammer_2;
extern canBus::signalNameCharStruct gSignalName_EmergHammer_3;
extern canBus::signalNameCharStruct gSignalName_EmergHammer_4;
extern canBus::signalNameCharStruct gSignalName_FireExting_1;
extern canBus::signalNameCharStruct gSignalName_FireExting_2;
extern canBus::signalNameCharStruct gSignalName_FireExting_3;
extern canBus::signalNameCharStruct gSignalName_FireExting_4;
extern canBus::messageNameCharStruct gMessageName_FS1;

extern canBus::signalNameCharStruct gSignalName_HVESS_Current;
extern canBus::signalNameCharStruct gSignalName_HVESS_VoltageLevel;
extern canBus::messageNameCharStruct gMessageName_HVESSD1;

extern canBus::signalNameCharStruct gSignalName_HVESS_FastUpdateSoc;
extern canBus::messageNameCharStruct gMessageName_HVESSD2;

extern canBus::signalNameCharStruct gSignalName_AverageCellTemp;
extern canBus::signalNameCharStruct gSignalName_HighestCellTemp;
extern canBus::signalNameCharStruct gSignalName_LowestCellTemp;
extern canBus::messageNameCharStruct gMessageName_HVESSD3;

extern canBus::signalNameCharStruct gSignalName_ChargeCurrentLimit;
extern canBus::signalNameCharStruct gSignalName_DischargeCurrentLimit;
extern canBus::messageNameCharStruct gMessageName_HVESSD5;

extern canBus::signalNameCharStruct gSignalName_ElectronicTemp;
extern canBus::messageNameCharStruct gMessageName_HVESSD6;

extern canBus::signalNameCharStruct gSignalName_HVESS_CenterOfPackContactor;
extern canBus::signalNameCharStruct gSignalName_HVESS_HvBusConnectionStatus;
extern canBus::signalNameCharStruct gSignalName_HVESS_HvBusPrechargeRelay;
extern canBus::signalNameCharStruct gSignalName_HVESS_HvNegativeContactorState;
extern canBus::signalNameCharStruct gSignalName_HVESS_HvPositiveContactorState;
extern canBus::messageNameCharStruct gMessageName_HVESSS1;

extern canBus::signalNameCharStruct gSignalName_IsoTpDataPC;
extern canBus::messageNameCharStruct gMessageName_ISOTP_PC_ID;

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

extern canBus::signalNameCharStruct gSignalName_LowBeamLightAuto;
extern canBus::messageNameCharStruct gMessageName_LD_2;

extern canBus::signalNameCharStruct gSignalName_ElectricEngineTemp;
extern canBus::messageNameCharStruct gMessageName_MCU2VCU2;

extern canBus::signalNameCharStruct gSignalName_FrontNonOperatorWiperSwitch;
extern canBus::signalNameCharStruct gSignalName_FrontOperatorWiperSwitch;
extern canBus::signalNameCharStruct gSignalName_WindshieldWasherOn;
extern canBus::messageNameCharStruct gMessageName_OWW;

extern canBus::signalNameCharStruct gSignalName_PantographModuleState;
extern canBus::messageNameCharStruct gMessageName_PCM1;

extern canBus::signalNameCharStruct gSignalName_HeatingWheel;
extern canBus::messageNameCharStruct gMessageName_SCU2CLM;

extern canBus::signalNameCharStruct gSignalName_InletWaterTemp;
extern canBus::signalNameCharStruct gSignalName_OutletWaterTemp;
extern canBus::signalNameCharStruct gSignalName_TMS_FaultCode;
extern canBus::signalNameCharStruct gSignalName_TmsMode;
extern canBus::messageNameCharStruct gMessageName_T2B_TMS1;

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

extern canBus::signalNameCharStruct gSignalName_TcoVehicleSpeed;
extern canBus::messageNameCharStruct gMessageName_TCO1_EE;

extern canBus::signalNameCharStruct gSignalName_TireAxis;
extern canBus::signalNameCharStruct gSignalName_TireLocation;
extern canBus::signalNameCharStruct gSignalName_TirePressure;
extern canBus::signalNameCharStruct gSignalName_TireTemp;
extern canBus::messageNameCharStruct gMessageName_TIRE;

extern canBus::signalNameCharStruct gSignalName_Energy_for_traction_daily;
extern canBus::signalNameCharStruct gSignalName_Energy_for_traction_total;
extern canBus::messageNameCharStruct gMessageName_TTS6;

extern canBus::signalNameCharStruct gSignalName_Energy_with_recuperation_daily;
extern canBus::signalNameCharStruct gSignalName_Energy_with_recuperation_total;
extern canBus::messageNameCharStruct gMessageName_TTS7;

extern canBus::signalNameCharStruct gSignalName_Energy_recuperation_total;
extern canBus::signalNameCharStruct gSignalName_Ratio_recup_to_energy_total;
extern canBus::messageNameCharStruct gMessageName_TTS8;

extern canBus::signalNameCharStruct gSignalName_Energy_recuperation_daily;
extern canBus::signalNameCharStruct gSignalName_Ratio_recup_to_energy_daily;
extern canBus::messageNameCharStruct gMessageName_TTS9;

extern canBus::signalNameCharStruct gSignalName_VDC_FullyOperational;
extern canBus::signalNameCharStruct gSignalName_VDC_InformationSignal;
extern canBus::messageNameCharStruct gMessageName_VDC1;

extern canBus::signalNameCharStruct gSignalName_ActualVoltage_24v;
extern canBus::messageNameCharStruct gMessageName_VEP1;

extern canBus::signalNameCharStruct gSignalName_KneelingControlModeReq;
extern canBus::signalNameCharStruct gSignalName_ReqRegulationBusFrontAxle;
extern canBus::signalNameCharStruct gSignalName_ReqRegulationBusRearAxle;
extern canBus::messageNameCharStruct gMessageName_ASC2_Tx;

extern canBus::signalNameCharStruct gSignalName_BtnBackAns;
extern canBus::signalNameCharStruct gSignalName_BtnMinusAns;
extern canBus::signalNameCharStruct gSignalName_BtnOkAns;
extern canBus::signalNameCharStruct gSignalName_BtnPlusAns;
extern canBus::signalNameCharStruct gSignalName_HearthBeat;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_1;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_2;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_3;
extern canBus::signalNameCharStruct gSignalName_IpAddressByte_4;
extern canBus::signalNameCharStruct gSignalName_KL_15;
extern canBus::signalNameCharStruct gSignalName_ProgramBuild;
extern canBus::signalNameCharStruct gSignalName_ProgramSubVersion;
extern canBus::signalNameCharStruct gSignalName_ProgramVersion;
extern canBus::messageNameCharStruct gMessageName_DB_1;

extern canBus::signalNameCharStruct gSignalName_AutoClossingDoors;
extern canBus::signalNameCharStruct gSignalName_CpuLoad;
extern canBus::signalNameCharStruct gSignalName_DisableSafety;
extern canBus::signalNameCharStruct gSignalName_MemLoad;
extern canBus::signalNameCharStruct gSignalName_PassengerDoorControl;
extern canBus::messageNameCharStruct gMessageName_DB_2;

extern canBus::signalNameCharStruct gSignalName_TurnLeftLamp;
extern canBus::signalNameCharStruct gSignalName_TurnRightLamp;
extern canBus::messageNameCharStruct gMessageName_DB_3;

extern canBus::signalNameCharStruct gSignalName_IsoTpDataDB;
extern canBus::messageNameCharStruct gMessageName_ISOTP_DASHBOARD_ID;

extern canBus::signalNameCharStruct gSignalName_TotalVehicleDistance;
extern canBus::signalNameCharStruct gSignalName_TripDistance;
extern canBus::messageNameCharStruct gMessageName_VDHR;

extern CanDataBase gCanDB;
#endif /* CANDATABASE_H_ */

